import 'exercise.dart';

enum SectionType { warmup, gym, homeAlt }

class WorkoutSection {
  final SectionType type;
  final String label;
  final String? sublabel;
  final List<Exercise> exercises;

  const WorkoutSection({
    required this.type,
    required this.label,
    this.sublabel,
    required this.exercises,
  });
}
