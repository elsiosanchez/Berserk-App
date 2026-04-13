import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../providers/workout_providers.dart';
import '../providers/locale_provider.dart';
import '../data/workout_data.dart';
import '../l10n/app_strings.dart';
import '../widgets/ritual_card.dart';
import '../widgets/stat_box.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final week = ref.watch(currentWeekProvider);
    final todayWorkout = ref.watch(todayWorkoutProvider);
    final todayIndex = ref.watch(todayDayIndexProvider);
    final completedDays = ref.watch(completedDaysProvider);
    final totalWorkouts = ref.watch(totalWorkoutsProvider);
    final streak = ref.watch(currentStreakProvider);
    final completionRate = ref.watch(weekCompletionRateProvider);

    return Scaffold(
      backgroundColor: BerserkColors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.appName,
                          style: BerserkTypography.h1.copyWith(
                            letterSpacing: 4,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${week.name} — ${week.subtitle}',
                          style: BerserkTypography.bodyText,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _showWeekSelector(context, ref),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: BerserkColors.card,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'W${week.weekNumber}',
                              style: BerserkTypography.h3.copyWith(
                                color: BerserkColors.accent,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.expand_more,
                              size: 18,
                              color: BerserkColors.accent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Stats row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: StatBox(
                        value: '$totalWorkouts',
                        label: S.workouts,
                        color: BerserkColors.accent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        value: '${(completionRate * 100).toInt()}%',
                        label: S.rate,
                        color: BerserkColors.success,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        value: '$streak',
                        label: S.streak,
                        color: BerserkColors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Week progress bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: BerserkColors.card,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.weeklyProgress, style: BerserkTypography.h3.copyWith(fontSize: 14)),
                      const SizedBox(height: 12),
                      Row(
                        children: List.generate(6, (index) {
                          final day = week.days[index];
                          final isCompleted = completedDays.contains(day.id);
                          final isToday = index == todayIndex;

                          return Expanded(
                            child: GestureDetector(
                              onTap: () => context.go('/workouts/day/${day.id}'),
                              child: Column(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: isCompleted
                                          ? BerserkColors.success
                                          : isToday
                                              ? BerserkColors.accent
                                              : BerserkColors.card2,
                                      shape: BoxShape.circle,
                                      border: isToday && !isCompleted
                                          ? Border.all(
                                              color: BerserkColors.accent,
                                              width: 2,
                                            )
                                          : null,
                                    ),
                                    child: Center(
                                      child: isCompleted
                                          ? const Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          : Text(
                                              S.dayLabels[index],
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: isToday
                                                    ? Colors.white
                                                    : BerserkColors.textTertiary,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: day.color.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Today's ritual section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Text(S.todaysRitual, style: BerserkTypography.h2),
              ),
            ),

            // Hero card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: todayWorkout != null
                    ? RitualCard(
                        day: todayWorkout,
                        weekName: week.name,
                        isCompleted: completedDays.contains(todayWorkout.id),
                        onTap: () => context.go('/workouts/day/${todayWorkout.id}'),
                      )
                    : _restDayCard(),
              ),
            ),

            // Week schedule section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Text(S.thisWeek, style: BerserkTypography.h2),
              ),
            ),

            // Day list
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final day = week.days[index];
                    final isCompleted = completedDays.contains(day.id);
                    final isToday = index == todayIndex;

                    return GestureDetector(
                      onTap: () => context.go('/workouts/day/${day.id}'),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: BerserkColors.card,
                          borderRadius: BorderRadius.circular(14),
                          border: isToday
                              ? Border.all(
                                  color: BerserkColors.accent.withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 3,
                              height: 40,
                              decoration: BoxDecoration(
                                color: day.color,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        day.name,
                                        style: BerserkTypography.h3.copyWith(fontSize: 15),
                                      ),
                                      if (isToday) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: BerserkColors.accent.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            S.today,
                                            style: const TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                              color: BerserkColors.accent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${S.dayLabels[day.dayIndex]} — ${S.get(day.subtitle)}',
                                    style: BerserkTypography.caption,
                                  ),
                                ],
                              ),
                            ),
                            if (isCompleted)
                              const Icon(
                                Icons.check_circle,
                                color: BerserkColors.success,
                                size: 22,
                              )
                            else
                              const Icon(
                                Icons.chevron_right,
                                color: BerserkColors.textTertiary,
                                size: 22,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: week.days.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _restDayCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.self_improvement,
            size: 48,
            color: BerserkColors.success,
          ),
          const SizedBox(height: 12),
          Text(S.restDay, style: BerserkTypography.h2),
          const SizedBox(height: 4),
          Text(
            S.restDayMessage,
            style: BerserkTypography.bodyText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showWeekSelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BerserkColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final currentIndex = ref.read(currentWeekIndexProvider);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: BerserkColors.textTertiary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(S.selectWeek, style: BerserkTypography.h2),
                const SizedBox(height: 16),
                ...List.generate(4, (index) {
                  final w = allWeeks[index];
                  final isSelected = index == currentIndex;
                  return GestureDetector(
                    onTap: () {
                      ref.read(currentWeekIndexProvider.notifier).state = index;
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? BerserkColors.accent.withOpacity(0.1)
                            : BerserkColors.card2,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: BerserkColors.accent, width: 1)
                            : null,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'W${w.weekNumber}',
                            style: BerserkTypography.h3.copyWith(
                              color: isSelected
                                  ? BerserkColors.accent
                                  : BerserkColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(w.name, style: BerserkTypography.h3.copyWith(fontSize: 15)),
                                Text(w.subtitle, style: BerserkTypography.caption),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: BerserkColors.accent,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
