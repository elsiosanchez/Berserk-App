import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../providers/active_workout_provider.dart';
import '../providers/workout_providers.dart';
import '../models/workout_section.dart';
import '../l10n/app_strings.dart';
import '../widgets/set_input_row.dart';
import '../widgets/rest_timer.dart';

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  ConsumerState<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  late PageController _pageController;
  Timer? _durationTimer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsedSeconds++);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _durationTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Color _sectionColor(SectionType type) {
    switch (type) {
      case SectionType.warmup:
        return BerserkColors.success;
      case SectionType.gym:
        return BerserkColors.accent;
      case SectionType.homeAlt:
        return const Color(0xFFE67E22);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activeWorkoutProvider);

    if (state.day == null || state.exercises.isEmpty) {
      return Scaffold(
        backgroundColor: BerserkColors.bg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.noWorkoutLoaded, style: BerserkTypography.bodyText),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.go('/workouts'),
                child: Text(S.goBack, style: BerserkTypography.h3.copyWith(color: BerserkColors.accent)),
              ),
            ],
          ),
        ),
      );
    }

    if (state.isFinished) {
      return _buildSummary(state);
    }

    return Stack(
      children: [
        Scaffold(
          backgroundColor: BerserkColors.bg,
          appBar: AppBar(
            backgroundColor: BerserkColors.bg,
            leading: IconButton(
              icon: const Icon(Icons.close, size: 22),
              onPressed: () => _showExitConfirmation(),
            ),
            title: Column(
              children: [
                Text(
                  state.day!.name,
                  style: BerserkTypography.h3.copyWith(fontSize: 14),
                ),
                Text(
                  _formatDuration(_elapsedSeconds),
                  style: BerserkTypography.caption.copyWith(
                    color: BerserkColors.accent,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(activeWorkoutProvider.notifier).finishWorkout();
                },
                child: Text(
                  S.finish,
                  style: const TextStyle(
                    color: BerserkColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Progress bar
              _buildProgressBar(state),
              // Exercise indicator dots
              _buildExerciseIndicator(state),
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: state.exercises.length,
                  onPageChanged: (index) {
                    ref.read(activeWorkoutProvider.notifier).goToExercise(index);
                  },
                  itemBuilder: (context, index) {
                    return _buildExercisePage(state, index);
                  },
                ),
              ),
            ],
          ),
        ),
        // Rest timer overlay
        if (state.isRestTimerActive) const RestTimer(),
      ],
    );
  }

  Widget _buildProgressBar(ActiveWorkoutState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.totalSetsCompleted}/${state.totalSets} ${S.sets}',
                style: BerserkTypography.caption,
              ),
              Text(
                '${(state.progress * 100).toInt()}%',
                style: BerserkTypography.caption.copyWith(
                  color: BerserkColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: state.progress,
              backgroundColor: BerserkColors.card2,
              valueColor: const AlwaysStoppedAnimation<Color>(BerserkColors.accent),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseIndicator(ActiveWorkoutState state) {
    return SizedBox(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: state.exercises.length,
        itemBuilder: (context, index) {
          final ae = state.exercises[index];
          final isCurrent = index == state.currentExerciseIndex;
          final sets = state.setData[ae.exercise.id] ?? [];
          final allDone = sets.isNotEmpty && sets.every((s) => s.completed);

          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              width: isCurrent ? 24 : 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 9),
              decoration: BoxDecoration(
                color: allDone
                    ? BerserkColors.success
                    : isCurrent
                        ? _sectionColor(ae.sectionType)
                        : BerserkColors.card2,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExercisePage(ActiveWorkoutState state, int index) {
    final ae = state.exercises[index];
    final exercise = ae.exercise;
    final sets = state.setData[exercise.id] ?? [];
    final sectionColor = _sectionColor(ae.sectionType);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: sectionColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              ae.sectionLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: sectionColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Exercise name
          Text(exercise.name, style: BerserkTypography.h1.copyWith(fontSize: 26)),
          const SizedBox(height: 6),
          // Info row
          Row(
            children: [
              _infoTag('${exercise.sets} ${S.sets}'),
              const SizedBox(width: 8),
              _infoTag('${exercise.reps} ${S.reps}'),
              if (exercise.rest != null && exercise.rest!.isNotEmpty) ...[
                const SizedBox(width: 8),
                _infoTag('${exercise.rest} rest'),
              ],
            ],
          ),
          if (exercise.tempo != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.speed, size: 14, color: BerserkColors.amber),
                const SizedBox(width: 4),
                Text(
                  'Tempo: ${exercise.tempo}',
                  style: BerserkTypography.caption.copyWith(color: BerserkColors.amber),
                ),
              ],
            ),
          ],
          if (exercise.notes != null) ...[
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: BerserkColors.card,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 14, color: BerserkColors.textTertiary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(exercise.notes!, style: BerserkTypography.caption),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          // Sets header
          Row(
            children: [
              const SizedBox(width: 44),
              Expanded(
                child: Text('WEIGHT', style: BerserkTypography.caption.copyWith(
                  fontSize: 10,
                  letterSpacing: 1,
                )),
              ),
              Expanded(
                child: Text('REPS', style: BerserkTypography.caption.copyWith(
                  fontSize: 10,
                  letterSpacing: 1,
                )),
              ),
              const SizedBox(width: 54),
            ],
          ),
          const SizedBox(height: 8),
          // Set rows
          ...List.generate(sets.length, (setIndex) {
            return SetInputRow(
              setIndex: setIndex,
              data: sets[setIndex],
              onWeightChanged: (w) {
                ref.read(activeWorkoutProvider.notifier)
                    .updateSet(exercise.id, setIndex, weight: w);
              },
              onRepsChanged: (r) {
                ref.read(activeWorkoutProvider.notifier)
                    .updateSet(exercise.id, setIndex, reps: r);
              },
              onCompleted: () {
                final wasCompleted = sets[setIndex].completed;
                ref.read(activeWorkoutProvider.notifier)
                    .completeSet(exercise.id, setIndex);
                // Start rest timer when completing (not uncompleting)
                if (!wasCompleted) {
                  ref.read(activeWorkoutProvider.notifier)
                      .startRestTimer(exercise.rest);
                }
              },
            );
          }),
          // Navigation hints
          const SizedBox(height: 24),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (index > 0) ...[
                  const Icon(Icons.chevron_left, size: 16, color: BerserkColors.textTertiary),
                  Text(S.swipePrevious, style: BerserkTypography.caption),
                ],
                if (index > 0 && index < state.exercises.length - 1)
                  const SizedBox(width: 16),
                if (index < state.exercises.length - 1) ...[
                  Text(S.swipeNext, style: BerserkTypography.caption),
                  const Icon(Icons.chevron_right, size: 16, color: BerserkColors.textTertiary),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: BerserkTypography.caption.copyWith(fontSize: 12),
      ),
    );
  }

  // ─── Summary screen ───

  Widget _buildSummary(ActiveWorkoutState state) {
    return Scaffold(
      backgroundColor: BerserkColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              // Trophy icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: BerserkColors.success.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 40,
                  color: BerserkColors.success,
                ),
              ),
              const SizedBox(height: 20),
              Text(S.workoutComplete, style: BerserkTypography.h1.copyWith(fontSize: 28)),
              const SizedBox(height: 4),
              Text(state.day?.name ?? '', style: BerserkTypography.bodyText),
              const SizedBox(height: 32),
              // Stats grid
              Row(
                children: [
                  Expanded(child: _summaryCard(
                    _formatDuration(_elapsedSeconds),
                    S.duration,
                    Icons.timer_outlined,
                    BerserkColors.accent,
                  )),
                  const SizedBox(width: 10),
                  Expanded(child: _summaryCard(
                    '${state.exercisesCompleted}/${state.exercises.length}',
                    S.exercises,
                    Icons.fitness_center,
                    BerserkColors.info,
                  )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _summaryCard(
                    '${state.totalSetsCompleted}',
                    S.setsDone,
                    Icons.check_circle_outline,
                    BerserkColors.success,
                  )),
                  const SizedBox(width: 10),
                  Expanded(child: _summaryCard(
                    '${state.totalVolume.toStringAsFixed(0)} kg',
                    S.totalVolume,
                    Icons.monitor_weight_outlined,
                    BerserkColors.amber,
                  )),
                ],
              ),
              const Spacer(),
              // Done button
              GestureDetector(
                onTap: () => _finishAndSave(state),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: BerserkColors.accent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      S.done,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 10),
          Text(value, style: BerserkTypography.statNumber.copyWith(fontSize: 20)),
          const SizedBox(height: 2),
          Text(label, style: BerserkTypography.caption),
        ],
      ),
    );
  }

  void _finishAndSave(ActiveWorkoutState state) {
    // Mark day as completed
    if (state.day != null) {
      ref.read(completedDaysProvider.notifier).update(
        (current) => {...current, state.day!.id},
      );
    }
    // Reset active workout
    ref.read(activeWorkoutProvider.notifier).reset();
    // Navigate back
    context.go('/workouts');
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: BerserkColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(S.quitWorkout, style: BerserkTypography.h2),
        content: Text(
          S.quitMessage,
          style: BerserkTypography.bodyText,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              S.keepGoing,
              style: const TextStyle(color: BerserkColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(activeWorkoutProvider.notifier).reset();
              context.go('/workouts');
            },
            child: Text(
              S.quit,
              style: const TextStyle(color: BerserkColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}
