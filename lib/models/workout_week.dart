import 'workout_day.dart';

class WorkoutWeek {
  final String id;
  final int weekNumber;
  final String name;
  final String subtitle;
  final List<WorkoutDay> days;

  const WorkoutWeek({
    required this.id,
    required this.weekNumber,
    required this.name,
    required this.subtitle,
    required this.days,
  });
}
