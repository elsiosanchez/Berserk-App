import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/exercise.dart';
import '../models/workout_day.dart';
import '../models/workout_log.dart';
import '../models/workout_section.dart';

// Flat exercise entry that includes section context
class ActiveExercise {
  final Exercise exercise;
  final SectionType sectionType;
  final String sectionLabel;

  const ActiveExercise({
    required this.exercise,
    required this.sectionType,
    required this.sectionLabel,
  });
}

// Mutable set data during workout
class ActiveSetData {
  double weight;
  int reps;
  bool completed;

  ActiveSetData({
    this.weight = 0,
    this.reps = 0,
    this.completed = false,
  });

  SetLog toLog() => SetLog(weight: weight, reps: reps, completed: completed);
}

// Full state for active workout
class ActiveWorkoutState {
  final WorkoutDay? day;
  final String? weekId;
  final List<ActiveExercise> exercises;
  final int currentExerciseIndex;
  final Map<String, List<ActiveSetData>> setData; // exerciseId -> sets
  final DateTime startTime;
  final bool isRestTimerActive;
  final int restSecondsRemaining;
  final int restSecondsTotal;
  final bool isFinished;

  const ActiveWorkoutState({
    this.day,
    this.weekId,
    this.exercises = const [],
    this.currentExerciseIndex = 0,
    this.setData = const {},
    required this.startTime,
    this.isRestTimerActive = false,
    this.restSecondsRemaining = 0,
    this.restSecondsTotal = 0,
    this.isFinished = false,
  });

  ActiveWorkoutState copyWith({
    WorkoutDay? day,
    String? weekId,
    List<ActiveExercise>? exercises,
    int? currentExerciseIndex,
    Map<String, List<ActiveSetData>>? setData,
    DateTime? startTime,
    bool? isRestTimerActive,
    int? restSecondsRemaining,
    int? restSecondsTotal,
    bool? isFinished,
  }) {
    return ActiveWorkoutState(
      day: day ?? this.day,
      weekId: weekId ?? this.weekId,
      exercises: exercises ?? this.exercises,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      setData: setData ?? this.setData,
      startTime: startTime ?? this.startTime,
      isRestTimerActive: isRestTimerActive ?? this.isRestTimerActive,
      restSecondsRemaining: restSecondsRemaining ?? this.restSecondsRemaining,
      restSecondsTotal: restSecondsTotal ?? this.restSecondsTotal,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  ActiveExercise? get currentExercise =>
      currentExerciseIndex < exercises.length ? exercises[currentExerciseIndex] : null;

  int get totalSetsCompleted {
    int count = 0;
    for (final sets in setData.values) {
      count += sets.where((s) => s.completed).length;
    }
    return count;
  }

  int get totalSets {
    int count = 0;
    for (final ex in exercises) {
      count += ex.exercise.sets;
    }
    return count;
  }

  double get totalVolume {
    double vol = 0;
    for (final sets in setData.values) {
      for (final s in sets) {
        if (s.completed) {
          vol += s.weight * s.reps;
        }
      }
    }
    return vol;
  }

  int get durationMinutes =>
      DateTime.now().difference(startTime).inMinutes;

  int get exercisesCompleted {
    int count = 0;
    for (final ex in exercises) {
      final sets = setData[ex.exercise.id];
      if (sets != null && sets.every((s) => s.completed)) {
        count++;
      }
    }
    return count;
  }

  double get progress => totalSets > 0 ? totalSetsCompleted / totalSets : 0;

  WorkoutLog toLog() {
    return WorkoutLog(
      id: '${day?.id}_${startTime.millisecondsSinceEpoch}',
      dayId: day?.id ?? '',
      weekId: weekId ?? '',
      date: startTime,
      durationMinutes: durationMinutes,
      completed: true,
      exercises: exercises.map((ae) {
        final sets = setData[ae.exercise.id] ?? [];
        return ExerciseLog(
          exerciseId: ae.exercise.id,
          sets: sets.map((s) => s.toLog()).toList(),
        );
      }).toList(),
    );
  }
}

class ActiveWorkoutNotifier extends StateNotifier<ActiveWorkoutState> {
  ActiveWorkoutNotifier()
      : super(ActiveWorkoutState(startTime: DateTime.now()));

  void startWorkout(WorkoutDay day, String weekId) {
    // Flatten all sections into a single exercise list
    final exercises = <ActiveExercise>[];
    for (final section in day.sections) {
      for (final exercise in section.exercises) {
        exercises.add(ActiveExercise(
          exercise: exercise,
          sectionType: section.type,
          sectionLabel: section.label,
        ));
      }
    }

    // Initialize set data for each exercise
    final setData = <String, List<ActiveSetData>>{};
    for (final ae in exercises) {
      setData[ae.exercise.id] = List.generate(
        ae.exercise.sets,
        (_) => ActiveSetData(),
      );
    }

    state = ActiveWorkoutState(
      day: day,
      weekId: weekId,
      exercises: exercises,
      currentExerciseIndex: 0,
      setData: setData,
      startTime: DateTime.now(),
    );
  }

  void goToExercise(int index) {
    if (index >= 0 && index < state.exercises.length) {
      state = state.copyWith(currentExerciseIndex: index);
    }
  }

  void updateSet(String exerciseId, int setIndex, {double? weight, int? reps}) {
    final newSetData = Map<String, List<ActiveSetData>>.from(state.setData);
    final sets = newSetData[exerciseId];
    if (sets != null && setIndex < sets.length) {
      if (weight != null) sets[setIndex].weight = weight;
      if (reps != null) sets[setIndex].reps = reps;
      state = state.copyWith(setData: newSetData);
    }
  }

  void completeSet(String exerciseId, int setIndex) {
    final newSetData = Map<String, List<ActiveSetData>>.from(state.setData);
    final sets = newSetData[exerciseId];
    if (sets != null && setIndex < sets.length) {
      sets[setIndex].completed = !sets[setIndex].completed;
      state = state.copyWith(setData: newSetData);
    }
  }

  int _parseRestSeconds(String? rest) {
    if (rest == null || rest.isEmpty) return 60;
    final cleaned = rest.replaceAll('s', '').trim();
    return int.tryParse(cleaned) ?? 60;
  }

  void startRestTimer(String? restString) {
    final seconds = _parseRestSeconds(restString);
    state = state.copyWith(
      isRestTimerActive: true,
      restSecondsRemaining: seconds,
      restSecondsTotal: seconds,
    );
  }

  void tickRestTimer() {
    if (state.restSecondsRemaining > 0) {
      state = state.copyWith(
        restSecondsRemaining: state.restSecondsRemaining - 1,
      );
    } else {
      state = state.copyWith(isRestTimerActive: false);
    }
  }

  void skipRestTimer() {
    state = state.copyWith(
      isRestTimerActive: false,
      restSecondsRemaining: 0,
    );
  }

  void finishWorkout() {
    state = state.copyWith(isFinished: true);
  }

  void reset() {
    state = ActiveWorkoutState(startTime: DateTime.now());
  }
}

final activeWorkoutProvider =
    StateNotifierProvider<ActiveWorkoutNotifier, ActiveWorkoutState>(
  (ref) => ActiveWorkoutNotifier(),
);
