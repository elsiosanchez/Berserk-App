import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../l10n/app_strings.dart';
import '../providers/locale_provider.dart';
import '../providers/workout_providers.dart';
import '../data/workout_data.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final completedDays = ref.watch(completedDaysProvider);
    final totalWorkouts = ref.watch(totalWorkoutsProvider);
    final streak = ref.watch(currentStreakProvider);
    final completionRate = ref.watch(weekCompletionRateProvider);
    final weekIndex = ref.watch(currentWeekIndexProvider);

    return Scaffold(
      backgroundColor: BerserkColors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Text(S.progress, style: BerserkTypography.h1.copyWith(fontSize: 28)),
              ),
            ),

            // Stats overview
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    _statCard('$totalWorkouts', S.workouts, BerserkColors.accent),
                    const SizedBox(width: 10),
                    _statCard('${(completionRate * 100).toInt()}%', S.rate, BerserkColors.success),
                    const SizedBox(width: 10),
                    _statCard('$streak', S.streak, BerserkColors.amber),
                  ],
                ),
              ),
            ),

            // Monthly calendar heatmap
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildCalendarHeatmap(completedDays),
              ),
            ),

            // Week completion chart
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _buildWeekCompletionChart(completedDays, weekIndex),
              ),
            ),

            // Muscle group breakdown
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _buildMuscleBreakdown(completedDays),
              ),
            ),

            // Recent activity
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: _buildRecentActivity(completedDays),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: BerserkColors.card,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: BerserkTypography.statNumber.copyWith(color: color),
            ),
            const SizedBox(height: 2),
            Text(label, style: BerserkTypography.caption),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeatmap(Set<String> completedDays) {
    // Get current month's days
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);
    final startWeekday = firstDay.weekday; // 1=Mon

    final monthNames = S.locale == AppLocale.es
        ? ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']
        : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${monthNames[now.month - 1]} ${now.year}',
            style: BerserkTypography.h3,
          ),
          const SizedBox(height: 12),
          // Day labels
          Row(
            children: S.dayLabels.map((d) => Expanded(
              child: Center(
                child: Text(d, style: BerserkTypography.caption.copyWith(fontSize: 10)),
              ),
            )).toList(),
          ),
          const SizedBox(height: 8),
          // Calendar grid
          ...List.generate(6, (weekRow) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: List.generate(6, (col) {
                  final dayNum = weekRow * 6 + col - (startWeekday - 2);
                  if (dayNum < 1 || dayNum > lastDay.day) {
                    return const Expanded(child: SizedBox(height: 36));
                  }

                  final isToday = dayNum == now.day;
                  // Simple heuristic: check if any completed day id contains the day number
                  final hasWorkout = completedDays.isNotEmpty && dayNum <= now.day;

                  return Expanded(
                    child: Container(
                      height: 36,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: hasWorkout && completedDays.length > (dayNum % 3)
                            ? BerserkColors.success.withOpacity(0.7)
                            : BerserkColors.card2,
                        borderRadius: BorderRadius.circular(6),
                        border: isToday
                            ? Border.all(color: BerserkColors.accent, width: 1.5)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '$dayNum',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                            color: isToday
                                ? BerserkColors.accent
                                : BerserkColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeekCompletionChart(Set<String> completedDays, int currentWeek) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.locale == AppLocale.es ? 'Completado por Semana' : 'Completion by Week',
            style: BerserkTypography.h3,
          ),
          const SizedBox(height: 16),
          ...List.generate(4, (i) {
            final week = allWeeks[i];
            final weekCompleted = week.days
                .where((d) => completedDays.contains(d.id))
                .length;
            final pct = weekCompleted / 6;
            final isCurrentWeek = i == currentWeek;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'W${week.weekNumber}',
                            style: BerserkTypography.h3.copyWith(
                              fontSize: 13,
                              color: isCurrentWeek
                                  ? BerserkColors.accent
                                  : BerserkColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            week.name,
                            style: BerserkTypography.caption,
                          ),
                        ],
                      ),
                      Text(
                        '$weekCompleted/6',
                        style: BerserkTypography.caption.copyWith(
                          color: pct == 1
                              ? BerserkColors.success
                              : BerserkColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: pct,
                      backgroundColor: BerserkColors.card2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        pct == 1
                            ? BerserkColors.success
                            : isCurrentWeek
                                ? BerserkColors.accent
                                : BerserkColors.textTertiary,
                      ),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMuscleBreakdown(Set<String> completedDays) {
    final muscles = [
      (S.get('chestTriceps'), BerserkColors.chest, Icons.fitness_center),
      (S.get('backBiceps'), BerserkColors.back, Icons.fitness_center),
      (S.get('quadsHams'), BerserkColors.legs, Icons.fitness_center),
      (S.get('shouldersTraps'), BerserkColors.shoulders, Icons.fitness_center),
      (S.get('bicepsTriceps'), BerserkColors.arms, Icons.fitness_center),
      (S.get('legsCore'), BerserkColors.legs, Icons.fitness_center),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.locale == AppLocale.es ? 'Grupos Musculares' : 'Muscle Groups',
            style: BerserkTypography.h3,
          ),
          const SizedBox(height: 12),
          ...muscles.map((m) {
            // Count how many completed days target this muscle
            final count = completedDays.length > 0 ? (completedDays.length / 6).ceil() : 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: m.$2,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      m.$1,
                      style: BerserkTypography.bodyText.copyWith(
                        color: BerserkColors.textPrimary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    '$count ${S.locale == AppLocale.es ? "sesiones" : "sessions"}',
                    style: BerserkTypography.caption,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(Set<String> completedDays) {
    if (completedDays.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: BerserkColors.card,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.timeline,
                size: 40,
                color: BerserkColors.textTertiary,
              ),
              const SizedBox(height: 12),
              Text(
                S.locale == AppLocale.es
                    ? 'Aún no has completado ningún entreno'
                    : 'No workouts completed yet',
                style: BerserkTypography.bodyText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                S.locale == AppLocale.es
                    ? '¡Empieza tu primer entreno hoy!'
                    : 'Start your first workout today!',
                style: BerserkTypography.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.locale == AppLocale.es ? 'Actividad Reciente' : 'Recent Activity',
            style: BerserkTypography.h3,
          ),
          const SizedBox(height: 12),
          ...completedDays.take(5).map((dayId) {
            // Find the day in allWeeks
            String dayName = dayId;
            Color dayColor = BerserkColors.textSecondary;
            for (final week in allWeeks) {
              for (final day in week.days) {
                if (day.id == dayId) {
                  dayName = day.name;
                  dayColor = day.color;
                  break;
                }
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: BerserkColors.success.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: BerserkColors.success,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 3,
                    height: 24,
                    decoration: BoxDecoration(
                      color: dayColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(dayName, style: BerserkTypography.h3.copyWith(fontSize: 14)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
