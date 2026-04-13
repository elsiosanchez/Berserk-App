import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/workout_data.dart';
import '../models/workout_week.dart';
import '../models/workout_day.dart';

// Current week index (0-3)
final currentWeekIndexProvider = StateProvider<int>((ref) => 0);

// Current week data
final currentWeekProvider = Provider<WorkoutWeek>((ref) {
  final index = ref.watch(currentWeekIndexProvider);
  return allWeeks[index];
});

// Today's workout day based on actual day of week (Mon=0 .. Sat=5, Sun=rest)
final todayDayIndexProvider = Provider<int>((ref) {
  final now = DateTime.now();
  // DateTime weekday: 1=Mon, 7=Sun
  final dayIndex = now.weekday - 1; // 0=Mon ... 6=Sun
  if (dayIndex >= 6) return -1; // Sunday = rest day
  return dayIndex;
});

// Today's workout (null on Sunday)
final todayWorkoutProvider = Provider<WorkoutDay?>((ref) {
  final week = ref.watch(currentWeekProvider);
  final dayIndex = ref.watch(todayDayIndexProvider);
  if (dayIndex < 0 || dayIndex >= week.days.length) return null;
  return week.days[dayIndex];
});

// Completed days tracking (set of dayIds)
final completedDaysProvider = StateProvider<Set<String>>((ref) => {});

// Stats
final totalWorkoutsProvider = Provider<int>((ref) {
  return ref.watch(completedDaysProvider).length;
});

final currentStreakProvider = Provider<int>((ref) {
  // Simplified: count consecutive completed days from today backwards
  final completed = ref.watch(completedDaysProvider);
  final week = ref.watch(currentWeekProvider);
  final todayIndex = ref.watch(todayDayIndexProvider);

  int streak = 0;
  for (int i = todayIndex; i >= 0; i--) {
    if (i < week.days.length && completed.contains(week.days[i].id)) {
      streak++;
    } else {
      break;
    }
  }
  return streak;
});

final weekCompletionRateProvider = Provider<double>((ref) {
  final completed = ref.watch(completedDaysProvider);
  final week = ref.watch(currentWeekProvider);
  if (week.days.isEmpty) return 0;

  final weekCompleted = week.days.where((d) => completed.contains(d.id)).length;
  return weekCompleted / week.days.length;
});

