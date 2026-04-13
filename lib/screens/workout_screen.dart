import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../providers/workout_providers.dart';
import '../providers/active_workout_provider.dart';
import '../providers/locale_provider.dart';
import '../models/workout_section.dart';
import '../l10n/app_strings.dart';
import '../widgets/section_row.dart';
import '../widgets/exercise_card.dart';

class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({super.key});

  Color _sectionAccent(SectionType type) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final week = ref.watch(currentWeekProvider);
    final dayId = GoRouterState.of(context).pathParameters['dayId'];
    final completedDays = ref.watch(completedDaysProvider);

    // Find the day
    final dayIndex = week.days.indexWhere((d) => d.id == dayId);
    if (dayIndex < 0) {
      return Scaffold(
        backgroundColor: BerserkColors.bg,
        appBar: AppBar(),
        body: Center(
          child: Text('Workout not found', style: BerserkTypography.bodyText),
        ),
      );
    }

    final day = week.days[dayIndex];
    final isCompleted = completedDays.contains(day.id);

    return Scaffold(
      backgroundColor: BerserkColors.bg,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            pinned: true,
            backgroundColor: BerserkColors.bg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () => context.go('/workouts'),
            ),
            title: Text(day.name, style: BerserkTypography.h3),
            actions: [
              if (!isCompleted)
                TextButton(
                  onPressed: () {
                    ref.read(completedDaysProvider.notifier).update(
                      (state) => {...state, day.id},
                    );
                  },
                  child: Text(
                    S.markDone,
                    style: TextStyle(
                      color: BerserkColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          // Header info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: BerserkColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Muscle group color indicator
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: day.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.fitness_center,
                        color: day.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.get(day.subtitle), style: BerserkTypography.h3),
                          const SizedBox(height: 2),
                          Text(
                            '${week.name} — ${S.dayLabels[day.dayIndex]}',
                            style: BerserkTypography.caption,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          day.estimatedTime,
                          style: BerserkTypography.h3.copyWith(
                            color: BerserkColors.accent,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${day.totalExercises} ${S.exercises}',
                          style: BerserkTypography.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Sections with exercises
          ...day.sections.expand((section) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: SectionRow(section: section),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ExerciseCard(
                        exercise: section.exercises[index],
                        accentColor: _sectionAccent(section.type),
                      ),
                      childCount: section.exercises.length,
                    ),
                  ),
                ),
              ]),

          // Start workout button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: GestureDetector(
                onTap: () {
                  if (!isCompleted) {
                    ref.read(activeWorkoutProvider.notifier)
                        .startWorkout(day, week.id);
                    context.push('/active-workout/${day.id}');
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: isCompleted ? BerserkColors.success : BerserkColors.accent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      isCompleted ? S.completed : S.startWorkout,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
