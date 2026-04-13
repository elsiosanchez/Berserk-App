import 'package:flutter/material.dart';
import 'workout_section.dart';

class WorkoutDay {
  final String id;
  final String name;
  final String subtitle;
  final String muscleGroup;
  final Color color;
  final int dayIndex; // 0=Monday ... 5=Saturday
  final List<WorkoutSection> sections;
  final String estimatedTime;

  const WorkoutDay({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.muscleGroup,
    required this.color,
    required this.dayIndex,
    required this.sections,
    required this.estimatedTime,
  });

  int get totalExercises =>
      sections.fold(0, (sum, s) => sum + s.exercises.length);

  int get totalSets =>
      sections.fold(
        0,
        (sum, s) => sum + s.exercises.fold(0, (sum2, e) => sum2 + e.sets),
      );
}
