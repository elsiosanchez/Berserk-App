class SetLog {
  final double weight;
  final int reps;
  final bool completed;

  const SetLog({
    required this.weight,
    required this.reps,
    this.completed = false,
  });
}

class ExerciseLog {
  final String exerciseId;
  final List<SetLog> sets;

  const ExerciseLog({
    required this.exerciseId,
    required this.sets,
  });
}

class WorkoutLog {
  final String id;
  final String dayId;
  final String weekId;
  final DateTime date;
  final int durationMinutes;
  final List<ExerciseLog> exercises;
  final bool completed;

  const WorkoutLog({
    required this.id,
    required this.dayId,
    required this.weekId,
    required this.date,
    required this.durationMinutes,
    required this.exercises,
    this.completed = false,
  });
}
