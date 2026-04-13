import 'dart:ui' show Color;

import '../models/exercise.dart';
import '../models/workout_section.dart';
import '../models/workout_day.dart';
import '../models/workout_week.dart';
import '../theme/berserk_colors.dart';

// ─── SHARED WARMUP EXERCISES (per muscle group) ───

const _warmupChest = [
  Exercise(id: 'wuC1', name: 'Rotaciones de Hombro', sets: 2, reps: '15', rest: '30s'),
  Exercise(id: 'wuC2', name: 'Band Pull-Aparts', sets: 2, reps: '15', rest: '30s'),
  Exercise(id: 'wuC3', name: 'Press de Banca Vacío', sets: 2, reps: '10', rest: '30s'),
];

const _warmupBack = [
  Exercise(id: 'wuB1', name: 'Cat-Cow Stretch', sets: 2, reps: '10', rest: '30s'),
  Exercise(id: 'wuB2', name: 'Dead Hangs', sets: 2, reps: '20s', rest: '30s'),
  Exercise(id: 'wuB3', name: 'Band Rows', sets: 2, reps: '15', rest: '30s'),
];

const _warmupLegs = [
  Exercise(id: 'wuL1', name: 'Sentadilla Goblet', sets: 2, reps: '10', rest: '30s'),
  Exercise(id: 'wuL2', name: 'Balanceo de Piernas', sets: 2, reps: '10 c/l', rest: '30s'),
  Exercise(id: 'wuL3', name: 'Puente de Glúteos', sets: 2, reps: '12', rest: '30s'),
];

const _warmupShoulders = [
  Exercise(id: 'wuS1', name: 'Círculos de Brazo', sets: 2, reps: '15 c/d', rest: '30s'),
  Exercise(id: 'wuS2', name: 'Elevaciones Laterales Ligeras', sets: 2, reps: '15', rest: '30s'),
  Exercise(id: 'wuS3', name: 'Press Vacío', sets: 2, reps: '10', rest: '30s'),
];

const _warmupArms = [
  Exercise(id: 'wuA1', name: 'Curls Ligeros', sets: 2, reps: '15', rest: '30s'),
  Exercise(id: 'wuA2', name: 'Estiramiento de Tríceps', sets: 2, reps: '30s', rest: '30s'),
];

const _warmupLegsCore = [
  Exercise(id: 'wuLC1', name: 'Círculos de Cadera', sets: 2, reps: '10 c/l', rest: '30s'),
  Exercise(id: 'wuLC2', name: 'Sentadillas Peso Corporal', sets: 2, reps: '12', rest: '30s'),
];

// ─── SHARED HOME/PARK ALTERNATIVES (per muscle group) ───

const _homeChestW1 = [
  Exercise(id: 'hC1a', name: 'Flexiones Diamante', sets: 3, reps: '12-15', rest: '60s'),
  Exercise(id: 'hC1b', name: 'Flexiones Declinadas', sets: 3, reps: '10-12', rest: '60s'),
  Exercise(id: 'hC1c', name: 'Fondos en Silla', sets: 3, reps: '10-12', rest: '60s'),
];

const _homeBackW1 = [
  Exercise(id: 'hB1a', name: 'Remo Invertido', sets: 3, reps: '10-12', rest: '60s'),
  Exercise(id: 'hB1b', name: 'Dominadas Australianas', sets: 3, reps: '8-10', rest: '60s'),
  Exercise(id: 'hB1c', name: 'Superman Hold', sets: 3, reps: '30s', rest: '45s'),
];

const _homeLegsW1 = [
  Exercise(id: 'hL1a', name: 'Sentadilla Búlgara', sets: 3, reps: '10 c/l', rest: '60s'),
  Exercise(id: 'hL1b', name: 'Zancadas Caminando', sets: 3, reps: '12 c/l', rest: '60s'),
  Exercise(id: 'hL1c', name: 'Puente de Glúteos a Una Pierna', sets: 3, reps: '10 c/l', rest: '60s'),
];

const _homeShouldersW1 = [
  Exercise(id: 'hS1a', name: 'Pike Push-ups', sets: 3, reps: '10-12', rest: '60s'),
  Exercise(id: 'hS1b', name: 'Elevaciones Laterales con Botella', sets: 3, reps: '15', rest: '45s'),
];

const _homeArmsW1 = [
  Exercise(id: 'hA1a', name: 'Flexiones Diamante', sets: 3, reps: '12-15', rest: '60s'),
  Exercise(id: 'hA1b', name: 'Curl con Mochila', sets: 3, reps: '12', rest: '60s'),
];

const _homeLegsCore = [
  Exercise(id: 'hLC1a', name: 'Sentadilla Pistol Asistida', sets: 3, reps: '6 c/l', rest: '60s'),
  Exercise(id: 'hLC1b', name: 'Plancha', sets: 3, reps: '45s', rest: '45s'),
  Exercise(id: 'hLC1c', name: 'Mountain Climbers', sets: 3, reps: '20', rest: '45s'),
];

// ─── Helper to build a WorkoutSection ───

WorkoutSection _warmup(List<Exercise> ex) =>
    WorkoutSection(type: SectionType.warmup, label: 'warmup', exercises: ex);

WorkoutSection _gym(List<Exercise> ex) =>
    WorkoutSection(type: SectionType.gym, label: 'gymRoutine', exercises: ex);

WorkoutSection _home(List<Exercise> ex) =>
    WorkoutSection(type: SectionType.homeAlt, label: 'homeAlt', exercises: ex);

// ═══════════════════════════════════════════════════════════════
// WEEK 1: Odin's Foundation — Technique & Form
// ═══════════════════════════════════════════════════════════════

final _w1Day1 = WorkoutDay(
  id: 'w1d1',
  name: "Berserker's Charge",
  subtitle: 'chestTriceps',
  muscleGroup: 'Chest',
  color: BerserkColors.chest,
  dayIndex: 0,
  estimatedTime: '55 min',
  sections: [
    _warmup(_warmupChest),
    _gym(const [
      Exercise(id: 'w1d1g1', name: 'Barbell Bench Press', sets: 4, reps: '8-10', rest: '90s', notes: 'Control the eccentric'),
      Exercise(id: 'w1d1g2', name: 'Incline Dumbbell Press', sets: 3, reps: '10-12', rest: '75s', tempo: '3-1-1'),
      Exercise(id: 'w1d1g3', name: 'Cable Flyes', sets: 3, reps: '12-15', rest: '60s'),
      Exercise(id: 'w1d1g4', name: 'Dips', sets: 3, reps: '8-10', rest: '75s'),
      Exercise(id: 'w1d1g5', name: 'Tricep Pushdowns', sets: 3, reps: '12-15', rest: '60s'),
    ]),
    _home(_homeChestW1),
  ],
);

final _w1Day2 = WorkoutDay(
  id: 'w1d2',
  name: "Raven's Pull",
  subtitle: 'backBiceps',
  muscleGroup: 'Back',
  color: BerserkColors.back,
  dayIndex: 1,
  estimatedTime: '60 min',
  sections: [
    _warmup(_warmupBack),
    _gym(const [
      Exercise(id: 'w1d2g1', name: 'Barbell Rows', sets: 4, reps: '8-10', rest: '90s', notes: 'Squeeze at the top'),
      Exercise(id: 'w1d2g2', name: 'Pull-ups', sets: 4, reps: '6-10', rest: '90s'),
      Exercise(id: 'w1d2g3', name: 'Seated Cable Row', sets: 3, reps: '10-12', rest: '75s'),
      Exercise(id: 'w1d2g4', name: 'Face Pulls', sets: 3, reps: '15', rest: '60s'),
      Exercise(id: 'w1d2g5', name: 'Barbell Curls', sets: 3, reps: '10-12', rest: '60s'),
      Exercise(id: 'w1d2g6', name: 'Hammer Curls', sets: 3, reps: '12', rest: '60s'),
    ]),
    _home(_homeBackW1),
  ],
);

final _w1Day3 = WorkoutDay(
  id: 'w1d3',
  name: "Jörmungandr's Squat",
  subtitle: 'quadsHams',
  muscleGroup: 'Legs',
  color: BerserkColors.legs,
  dayIndex: 2,
  estimatedTime: '60 min',
  sections: [
    _warmup(_warmupLegs),
    _gym(const [
      Exercise(id: 'w1d3g1', name: 'Back Squat', sets: 4, reps: '8-10', rest: '120s', notes: 'Below parallel'),
      Exercise(id: 'w1d3g2', name: 'Romanian Deadlift', sets: 4, reps: '10-12', rest: '90s'),
      Exercise(id: 'w1d3g3', name: 'Leg Press', sets: 3, reps: '12-15', rest: '90s'),
      Exercise(id: 'w1d3g4', name: 'Walking Lunges', sets: 3, reps: '12 each', rest: '75s'),
      Exercise(id: 'w1d3g5', name: 'Leg Curls', sets: 3, reps: '12-15', rest: '60s'),
    ]),
    _home(_homeLegsW1),
  ],
);

final _w1Day4 = WorkoutDay(
  id: 'w1d4',
  name: "Valkyrie's Press",
  subtitle: 'shouldersTraps',
  muscleGroup: 'Shoulders',
  color: BerserkColors.shoulders,
  dayIndex: 3,
  estimatedTime: '50 min',
  sections: [
    _warmup(_warmupShoulders),
    _gym(const [
      Exercise(id: 'w1d4g1', name: 'Overhead Press', sets: 4, reps: '8-10', rest: '90s', notes: 'Strict form'),
      Exercise(id: 'w1d4g2', name: 'Dumbbell Lateral Raises', sets: 4, reps: '12-15', rest: '60s'),
      Exercise(id: 'w1d4g3', name: 'Rear Delt Flyes', sets: 3, reps: '15', rest: '60s'),
      Exercise(id: 'w1d4g4', name: 'Barbell Shrugs', sets: 3, reps: '12-15', rest: '60s'),
      Exercise(id: 'w1d4g5', name: 'Arnold Press', sets: 3, reps: '10-12', rest: '75s'),
    ]),
    _home(_homeShouldersW1),
  ],
);

final _w1Day5 = WorkoutDay(
  id: 'w1d5',
  name: "Mjölnir's Grip",
  subtitle: 'bicepsTriceps',
  muscleGroup: 'Arms',
  color: BerserkColors.arms,
  dayIndex: 4,
  estimatedTime: '45 min',
  sections: [
    _warmup(_warmupArms),
    _gym(const [
      Exercise(id: 'w1d5g1', name: 'EZ Bar Curls', sets: 4, reps: '10-12', rest: '75s'),
      Exercise(id: 'w1d5g2', name: 'Skull Crushers', sets: 4, reps: '10-12', rest: '75s'),
      Exercise(id: 'w1d5g3', name: 'Incline Dumbbell Curls', sets: 3, reps: '12', rest: '60s'),
      Exercise(id: 'w1d5g4', name: 'Overhead Tricep Extension', sets: 3, reps: '12', rest: '60s'),
      Exercise(id: 'w1d5g5', name: 'Concentration Curls', sets: 3, reps: '10 each', rest: '60s'),
      Exercise(id: 'w1d5g6', name: 'Diamond Push-ups', sets: 3, reps: '10-15', rest: '60s'),
    ]),
    _home(_homeArmsW1),
  ],
);

final _w1Day6 = WorkoutDay(
  id: 'w1d6',
  name: "Yggdrasil's Roots",
  subtitle: 'legsCore',
  muscleGroup: 'Legs',
  color: BerserkColors.legs,
  dayIndex: 5,
  estimatedTime: '55 min',
  sections: [
    _warmup(_warmupLegsCore),
    _gym(const [
      Exercise(id: 'w1d6g1', name: 'Front Squat', sets: 4, reps: '8-10', rest: '90s'),
      Exercise(id: 'w1d6g2', name: 'Bulgarian Split Squats', sets: 3, reps: '10 each', rest: '75s'),
      Exercise(id: 'w1d6g3', name: 'Hip Thrust', sets: 3, reps: '12', rest: '75s'),
      Exercise(id: 'w1d6g4', name: 'Calf Raises', sets: 4, reps: '15-20', rest: '60s'),
      Exercise(id: 'w1d6g5', name: 'Hanging Leg Raises', sets: 3, reps: '12-15', rest: '60s'),
      Exercise(id: 'w1d6g6', name: 'Plank', sets: 3, reps: '45s hold', rest: '45s'),
    ]),
    _home(_homeLegsCore),
  ],
);

// ═══════════════════════════════════════════════════════════════
// WEEK 2: Thor's Variation — Volume & Range
// ═══════════════════════════════════════════════════════════════

WorkoutDay _makeDay(String id, String name, String subtitle, String muscle,
    Color color, int dayIdx, String time,
    List<Exercise> warmup, List<Exercise> gym, List<Exercise> home) {
  return WorkoutDay(
    id: id, name: name, subtitle: subtitle, muscleGroup: muscle,
    color: color, dayIndex: dayIdx, estimatedTime: time,
    sections: [_warmup(warmup), _gym(gym), _home(home)],
  );
}

final _w2Day1 = _makeDay('w2d1', "Berserker's Charge", 'chestTriceps', 'Chest',
    BerserkColors.chest, 0, '60 min', _warmupChest, const [
  Exercise(id: 'w2d1g1', name: 'Dumbbell Bench Press', sets: 4, reps: '10-12', rest: '90s', variation: 'Switched from barbell'),
  Exercise(id: 'w2d1g2', name: 'Barbell Incline Press', sets: 4, reps: '8-10', rest: '90s'),
  Exercise(id: 'w2d1g3', name: 'Pec Deck Machine', sets: 3, reps: '12-15', rest: '60s'),
  Exercise(id: 'w2d1g4', name: 'Weighted Dips', sets: 3, reps: '8-10', rest: '75s'),
  Exercise(id: 'w2d1g5', name: 'Rope Pushdowns', sets: 3, reps: '15', rest: '60s'),
  Exercise(id: 'w2d1g6', name: 'Close-Grip Bench Press', sets: 3, reps: '10-12', rest: '75s'),
], _homeChestW1);

final _w2Day2 = _makeDay('w2d2', "Raven's Pull", 'backBiceps', 'Back',
    BerserkColors.back, 1, '60 min', _warmupBack, const [
  Exercise(id: 'w2d2g1', name: 'Weighted Pull-ups', sets: 4, reps: '6-8', rest: '120s'),
  Exercise(id: 'w2d2g2', name: 'T-Bar Row', sets: 4, reps: '10-12', rest: '90s'),
  Exercise(id: 'w2d2g3', name: 'Single-Arm Dumbbell Row', sets: 3, reps: '10 each', rest: '75s'),
  Exercise(id: 'w2d2g4', name: 'Lat Pulldown', sets: 3, reps: '12-15', rest: '60s'),
  Exercise(id: 'w2d2g5', name: 'Preacher Curls', sets: 3, reps: '10-12', rest: '60s'),
  Exercise(id: 'w2d2g6', name: 'Cable Curls', sets: 3, reps: '12-15', rest: '60s'),
], _homeBackW1);

final _w2Day3 = _makeDay('w2d3', "Jörmungandr's Squat", 'quadsHams', 'Legs',
    BerserkColors.legs, 2, '65 min', _warmupLegs, const [
  Exercise(id: 'w2d3g1', name: 'Back Squat', sets: 5, reps: '6-8', rest: '120s', variation: 'Heavier, lower reps'),
  Exercise(id: 'w2d3g2', name: 'Sumo Deadlift', sets: 4, reps: '8-10', rest: '120s'),
  Exercise(id: 'w2d3g3', name: 'Hack Squat', sets: 3, reps: '10-12', rest: '90s'),
  Exercise(id: 'w2d3g4', name: 'Nordic Curls', sets: 3, reps: '6-8', rest: '90s'),
  Exercise(id: 'w2d3g5', name: 'Leg Extensions', sets: 3, reps: '15', rest: '60s'),
], _homeLegsW1);

final _w2Day4 = _makeDay('w2d4', "Valkyrie's Press", 'shouldersTraps', 'Shoulders',
    BerserkColors.shoulders, 3, '50 min', _warmupShoulders, const [
  Exercise(id: 'w2d4g1', name: 'Push Press', sets: 4, reps: '6-8', rest: '90s', variation: 'More explosive'),
  Exercise(id: 'w2d4g2', name: 'Cable Lateral Raises', sets: 4, reps: '12-15', rest: '60s'),
  Exercise(id: 'w2d4g3', name: 'Reverse Pec Deck', sets: 3, reps: '15', rest: '60s'),
  Exercise(id: 'w2d4g4', name: 'Dumbbell Shrugs', sets: 3, reps: '15', rest: '60s'),
  Exercise(id: 'w2d4g5', name: 'Landmine Press', sets: 3, reps: '10 each', rest: '75s'),
], _homeShouldersW1);

final _w2Day5 = _makeDay('w2d5', "Mjölnir's Grip", 'bicepsTriceps', 'Arms',
    BerserkColors.arms, 4, '50 min', _warmupArms, const [
  Exercise(id: 'w2d5g1', name: 'Barbell Curls', sets: 4, reps: '8-10', rest: '75s'),
  Exercise(id: 'w2d5g2', name: 'Close-Grip Bench', sets: 4, reps: '8-10', rest: '90s'),
  Exercise(id: 'w2d5g3', name: 'Spider Curls', sets: 3, reps: '12', rest: '60s'),
  Exercise(id: 'w2d5g4', name: 'Dip Machine', sets: 3, reps: '12-15', rest: '60s'),
  Exercise(id: 'w2d5g5', name: 'Cross-Body Hammer Curls', sets: 3, reps: '12 each', rest: '60s'),
  Exercise(id: 'w2d5g6', name: 'Tricep Kickbacks', sets: 3, reps: '12', rest: '60s'),
], _homeArmsW1);

final _w2Day6 = _makeDay('w2d6', "Yggdrasil's Roots", 'legsCore', 'Legs',
    BerserkColors.legs, 5, '55 min', _warmupLegsCore, const [
  Exercise(id: 'w2d6g1', name: 'Trap Bar Deadlift', sets: 4, reps: '8-10', rest: '120s'),
  Exercise(id: 'w2d6g2', name: 'Step-Ups', sets: 3, reps: '10 each', rest: '75s'),
  Exercise(id: 'w2d6g3', name: 'Leg Press (Narrow Stance)', sets: 3, reps: '12', rest: '75s'),
  Exercise(id: 'w2d6g4', name: 'Seated Calf Raises', sets: 4, reps: '15-20', rest: '60s'),
  Exercise(id: 'w2d6g5', name: 'Ab Rollout', sets: 3, reps: '10-12', rest: '60s'),
  Exercise(id: 'w2d6g6', name: 'Russian Twists', sets: 3, reps: '20', rest: '45s'),
], _homeLegsCore);

// ═══════════════════════════════════════════════════════════════
// WEEK 3: Tyr's Intensity — Pause & Tempo
// ═══════════════════════════════════════════════════════════════

// Week 3 home alternatives – intermediate versions
const _homeChestW3 = [
  Exercise(id: 'hC3a', name: 'Flexiones Explosivas', sets: 3, reps: '10-12', rest: '60s'),
  Exercise(id: 'hC3b', name: 'Flexiones Archer', sets: 3, reps: '6 c/l', rest: '60s'),
];

const _homeBackW3 = [
  Exercise(id: 'hB3a', name: 'Dominadas Tempo (4s bajada)', sets: 3, reps: '5-8', rest: '90s'),
  Exercise(id: 'hB3b', name: 'Remo Invertido con Pausa', sets: 3, reps: '8-10', rest: '60s'),
];

const _homeLegsW3 = [
  Exercise(id: 'hL3a', name: 'Sentadilla Pistol Asistida', sets: 3, reps: '6 c/l', rest: '90s'),
  Exercise(id: 'hL3b', name: 'Nordic Curl Negativo', sets: 3, reps: '5', rest: '90s'),
];

const _homeShouldersW3 = [
  Exercise(id: 'hS3a', name: 'Pike Push-up Elevado', sets: 3, reps: '8-10', rest: '75s'),
  Exercise(id: 'hS3b', name: 'Handstand Hold en Pared', sets: 3, reps: '20s', rest: '60s'),
];

const _homeArmsW3 = [
  Exercise(id: 'hA3a', name: 'Flexiones Diamante Tempo', sets: 3, reps: '8', rest: '60s'),
  Exercise(id: 'hA3b', name: 'Curl Isométrico con Toalla', sets: 3, reps: '20s', rest: '45s'),
];

const _homeLegsCoreW3 = [
  Exercise(id: 'hLC3a', name: 'Sentadilla Búlgara con Salto', sets: 3, reps: '8 c/l', rest: '60s'),
  Exercise(id: 'hLC3b', name: 'Dragon Flag Negativo', sets: 3, reps: '5', rest: '60s'),
];

final _w3Day1 = _makeDay('w3d1', "Berserker's Charge", 'chestTriceps', 'Chest',
    BerserkColors.chest, 0, '60 min', _warmupChest, const [
  Exercise(id: 'w3d1g1', name: 'Pause Bench Press', sets: 4, reps: '6-8', rest: '120s', tempo: '3-2-1', notes: '2s pause at bottom'),
  Exercise(id: 'w3d1g2', name: 'Tempo Incline DB Press', sets: 4, reps: '8-10', rest: '90s', tempo: '4-1-1'),
  Exercise(id: 'w3d1g3', name: 'Cable Flyes (Low to High)', sets: 3, reps: '12', rest: '60s'),
  Exercise(id: 'w3d1g4', name: 'Pause Dips', sets: 3, reps: '8', rest: '90s', tempo: '2-2-1'),
  Exercise(id: 'w3d1g5', name: 'Overhead Tricep Extension', sets: 3, reps: '12', rest: '60s'),
], _homeChestW3);

final _w3Day2 = _makeDay('w3d2', "Raven's Pull", 'backBiceps', 'Back',
    BerserkColors.back, 1, '60 min', _warmupBack, const [
  Exercise(id: 'w3d2g1', name: 'Pause Barbell Row', sets: 4, reps: '8', rest: '90s', tempo: '2-2-1'),
  Exercise(id: 'w3d2g2', name: 'Tempo Pull-ups', sets: 4, reps: '5-8', rest: '120s', tempo: '4-1-1'),
  Exercise(id: 'w3d2g3', name: 'Chest-Supported DB Row', sets: 3, reps: '10-12', rest: '75s'),
  Exercise(id: 'w3d2g4', name: 'Straight-Arm Pulldown', sets: 3, reps: '12-15', rest: '60s'),
  Exercise(id: 'w3d2g5', name: 'Pause Barbell Curls', sets: 3, reps: '10', rest: '60s', tempo: '2-2-1'),
  Exercise(id: 'w3d2g6', name: 'Incline Hammer Curls', sets: 3, reps: '12', rest: '60s'),
], _homeBackW3);

final _w3Day3 = _makeDay('w3d3', "Jörmungandr's Squat", 'quadsHams', 'Legs',
    BerserkColors.legs, 2, '65 min', _warmupLegs, const [
  Exercise(id: 'w3d3g1', name: 'Pause Squat', sets: 4, reps: '5-6', rest: '150s', tempo: '3-3-1', notes: '3s pause in the hole'),
  Exercise(id: 'w3d3g2', name: 'Tempo RDL', sets: 4, reps: '8-10', rest: '90s', tempo: '4-1-1'),
  Exercise(id: 'w3d3g3', name: 'Sissy Squat', sets: 3, reps: '10-12', rest: '75s'),
  Exercise(id: 'w3d3g4', name: 'Glute-Ham Raise', sets: 3, reps: '8-10', rest: '90s'),
  Exercise(id: 'w3d3g5', name: 'Tempo Leg Extension', sets: 3, reps: '12', rest: '60s', tempo: '3-1-1'),
], _homeLegsW3);

final _w3Day4 = _makeDay('w3d4', "Valkyrie's Press", 'shouldersTraps', 'Shoulders',
    BerserkColors.shoulders, 3, '50 min', _warmupShoulders, const [
  Exercise(id: 'w3d4g1', name: 'Pause Overhead Press', sets: 4, reps: '6-8', rest: '120s', tempo: '2-2-1'),
  Exercise(id: 'w3d4g2', name: 'Tempo Lateral Raises', sets: 4, reps: '10-12', rest: '60s', tempo: '3-1-1'),
  Exercise(id: 'w3d4g3', name: 'Cable Rear Delts', sets: 3, reps: '15', rest: '60s'),
  Exercise(id: 'w3d4g4', name: 'Pause Shrugs', sets: 3, reps: '12', rest: '60s', tempo: '1-3-1'),
  Exercise(id: 'w3d4g5', name: 'Z Press', sets: 3, reps: '8-10', rest: '75s'),
], _homeShouldersW3);

final _w3Day5 = _makeDay('w3d5', "Mjölnir's Grip", 'bicepsTriceps', 'Arms',
    BerserkColors.arms, 4, '50 min', _warmupArms, const [
  Exercise(id: 'w3d5g1', name: 'Tempo Barbell Curls', sets: 4, reps: '8', rest: '75s', tempo: '4-1-1'),
  Exercise(id: 'w3d5g2', name: 'Pause Skull Crushers', sets: 4, reps: '8', rest: '75s', tempo: '2-2-1'),
  Exercise(id: 'w3d5g3', name: 'Tempo Preacher Curls', sets: 3, reps: '10', rest: '60s', tempo: '3-1-1'),
  Exercise(id: 'w3d5g4', name: 'Pause Dip Machine', sets: 3, reps: '10', rest: '60s'),
  Exercise(id: 'w3d5g5', name: '21s Curls', sets: 3, reps: '7/7/7', rest: '90s'),
  Exercise(id: 'w3d5g6', name: 'Rope Pushdown (Slow)', sets: 3, reps: '12', rest: '60s', tempo: '3-1-1'),
], _homeArmsW3);

final _w3Day6 = _makeDay('w3d6', "Yggdrasil's Roots", 'legsCore', 'Legs',
    BerserkColors.legs, 5, '55 min', _warmupLegsCore, const [
  Exercise(id: 'w3d6g1', name: 'Tempo Front Squat', sets: 4, reps: '6-8', rest: '120s', tempo: '4-1-1'),
  Exercise(id: 'w3d6g2', name: 'Pause Bulgarian Splits', sets: 3, reps: '8 each', rest: '90s', tempo: '2-2-1'),
  Exercise(id: 'w3d6g3', name: 'Single-Leg Hip Thrust', sets: 3, reps: '10 each', rest: '75s'),
  Exercise(id: 'w3d6g4', name: 'Tempo Calf Raises', sets: 4, reps: '12', rest: '60s', tempo: '3-2-1'),
  Exercise(id: 'w3d6g5', name: 'Dragon Flags', sets: 3, reps: '6-8', rest: '75s'),
  Exercise(id: 'w3d6g6', name: 'Hollow Hold', sets: 3, reps: '30s', rest: '45s'),
], _homeLegsCoreW3);

// ═══════════════════════════════════════════════════════════════
// WEEK 4: Fenrir Unleashed — PRs & Drop Sets
// ═══════════════════════════════════════════════════════════════

// Week 4 home alternatives – advanced versions
const _homeChestW4 = [
  Exercise(id: 'hC4a', name: 'Flexiones con Palmada', sets: 3, reps: '8-10', rest: '60s'),
  Exercise(id: 'hC4b', name: 'Flexiones a Una Mano Asistida', sets: 3, reps: '5 c/l', rest: '75s'),
];

const _homeBackW4 = [
  Exercise(id: 'hB4a', name: 'Dominadas Lastradas (Mochila)', sets: 3, reps: '5-8', rest: '90s'),
  Exercise(id: 'hB4b', name: 'Remo Invertido a Una Mano', sets: 3, reps: '8 c/l', rest: '60s'),
];

const _homeLegsW4 = [
  Exercise(id: 'hL4a', name: 'Sentadilla Pistol', sets: 3, reps: '5 c/l', rest: '90s'),
  Exercise(id: 'hL4b', name: 'Salto al Cajón', sets: 3, reps: '8', rest: '75s'),
];

const _homeShouldersW4 = [
  Exercise(id: 'hS4a', name: 'Handstand Push-up Asistido', sets: 3, reps: '5-8', rest: '90s'),
  Exercise(id: 'hS4b', name: 'Pike Push-up Deficit', sets: 3, reps: '8-10', rest: '60s'),
];

const _homeArmsW4 = [
  Exercise(id: 'hA4a', name: 'Flexiones Diamante Lastradas', sets: 3, reps: '10', rest: '60s'),
  Exercise(id: 'hA4b', name: 'Chin-ups Negativas Lentas', sets: 3, reps: '5', rest: '75s'),
];

const _homeLegsCoreW4 = [
  Exercise(id: 'hLC4a', name: 'Sentadilla Pistol Lastrada', sets: 3, reps: '5 c/l', rest: '90s'),
  Exercise(id: 'hLC4b', name: 'Dragon Flag Completo', sets: 3, reps: '5-8', rest: '75s'),
];

final _w4Day1 = _makeDay('w4d1', "Berserker's Charge", 'chestTriceps', 'Chest',
    BerserkColors.chest, 0, '65 min', _warmupChest, const [
  Exercise(id: 'w4d1g1', name: 'Bench Press — PR Attempt', sets: 5, reps: '3-5', rest: '180s', notes: 'Go heavy!'),
  Exercise(id: 'w4d1g2', name: 'Incline DB Press + Drop Set', sets: 4, reps: '8 + drop', rest: '90s'),
  Exercise(id: 'w4d1g3', name: 'Cable Flyes + Drop Set', sets: 3, reps: '10 + drop', rest: '60s'),
  Exercise(id: 'w4d1g4', name: 'Weighted Dips', sets: 3, reps: '6-8', rest: '90s', notes: 'PR attempt'),
  Exercise(id: 'w4d1g5', name: 'Skull Crushers + Drop Set', sets: 3, reps: '8 + drop', rest: '75s'),
], _homeChestW4);

final _w4Day2 = _makeDay('w4d2', "Raven's Pull", 'backBiceps', 'Back',
    BerserkColors.back, 1, '65 min', _warmupBack, const [
  Exercise(id: 'w4d2g1', name: 'Deadlift — PR Attempt', sets: 5, reps: '3-5', rest: '180s', notes: 'Go heavy!'),
  Exercise(id: 'w4d2g2', name: 'Weighted Pull-ups — PR', sets: 4, reps: '3-6', rest: '150s'),
  Exercise(id: 'w4d2g3', name: 'Barbell Row + Drop Set', sets: 3, reps: '8 + drop', rest: '90s'),
  Exercise(id: 'w4d2g4', name: 'Lat Pulldown + Drop Set', sets: 3, reps: '10 + drop', rest: '60s'),
  Exercise(id: 'w4d2g5', name: 'Barbell Curl — PR Attempt', sets: 4, reps: '6-8', rest: '75s'),
  Exercise(id: 'w4d2g6', name: 'Hammer Curls + Drop Set', sets: 3, reps: '10 + drop', rest: '60s'),
], _homeBackW4);

final _w4Day3 = _makeDay('w4d3', "Jörmungandr's Squat", 'quadsHams', 'Legs',
    BerserkColors.legs, 2, '70 min', _warmupLegs, const [
  Exercise(id: 'w4d3g1', name: 'Back Squat — PR Attempt', sets: 5, reps: '3-5', rest: '180s', notes: 'Go heavy!'),
  Exercise(id: 'w4d3g2', name: 'RDL — Heavy', sets: 4, reps: '6-8', rest: '120s'),
  Exercise(id: 'w4d3g3', name: 'Leg Press + Drop Set', sets: 3, reps: '10 + drop', rest: '90s'),
  Exercise(id: 'w4d3g4', name: 'Walking Lunges — Heavy', sets: 3, reps: '10 each', rest: '90s'),
  Exercise(id: 'w4d3g5', name: 'Leg Curl + Drop Set', sets: 3, reps: '10 + drop', rest: '60s'),
], _homeLegsW4);

final _w4Day4 = _makeDay('w4d4', "Valkyrie's Press", 'shouldersTraps', 'Shoulders',
    BerserkColors.shoulders, 3, '55 min', _warmupShoulders, const [
  Exercise(id: 'w4d4g1', name: 'OHP — PR Attempt', sets: 5, reps: '3-5', rest: '180s', notes: 'Go heavy!'),
  Exercise(id: 'w4d4g2', name: 'Lateral Raise + Drop Set', sets: 4, reps: '10 + drop', rest: '60s'),
  Exercise(id: 'w4d4g3', name: 'Rear Delt Fly + Drop', sets: 3, reps: '12 + drop', rest: '60s'),
  Exercise(id: 'w4d4g4', name: 'Heavy Shrugs', sets: 4, reps: '10-12', rest: '75s'),
  Exercise(id: 'w4d4g5', name: 'Push Press — Heavy', sets: 3, reps: '5-6', rest: '120s'),
], _homeShouldersW4);

final _w4Day5 = _makeDay('w4d5', "Mjölnir's Grip", 'bicepsTriceps', 'Arms',
    BerserkColors.arms, 4, '50 min', _warmupArms, const [
  Exercise(id: 'w4d5g1', name: 'Barbell Curl — PR', sets: 4, reps: '5-6', rest: '90s', notes: 'Go heavy!'),
  Exercise(id: 'w4d5g2', name: 'Skull Crushers — PR', sets: 4, reps: '5-6', rest: '90s'),
  Exercise(id: 'w4d5g3', name: 'Preacher Curl + Drop', sets: 3, reps: '8 + drop', rest: '60s'),
  Exercise(id: 'w4d5g4', name: 'Tricep Pushdown + Drop', sets: 3, reps: '10 + drop', rest: '60s'),
  Exercise(id: 'w4d5g5', name: 'Hammer Curl + Drop', sets: 3, reps: '8 + drop', rest: '60s'),
  Exercise(id: 'w4d5g6', name: 'Overhead Ext + Drop', sets: 3, reps: '10 + drop', rest: '60s'),
], _homeArmsW4);

final _w4Day6 = _makeDay('w4d6', "Yggdrasil's Roots", 'legsCore', 'Legs',
    BerserkColors.legs, 5, '60 min', _warmupLegsCore, const [
  Exercise(id: 'w4d6g1', name: 'Front Squat — Heavy', sets: 4, reps: '5-6', rest: '150s'),
  Exercise(id: 'w4d6g2', name: 'Bulgarian Splits — Heavy', sets: 3, reps: '8 each', rest: '90s'),
  Exercise(id: 'w4d6g3', name: 'Hip Thrust — PR', sets: 4, reps: '6-8', rest: '90s'),
  Exercise(id: 'w4d6g4', name: 'Calf Raise + Drop Set', sets: 4, reps: '12 + drop', rest: '60s'),
  Exercise(id: 'w4d6g5', name: 'Weighted Plank', sets: 3, reps: '45s', rest: '60s'),
  Exercise(id: 'w4d6g6', name: 'Hanging Leg Raise', sets: 3, reps: '12-15', rest: '60s'),
], _homeLegsCoreW4);

// ═══════════════════════════════════════════════════════════════
// ALL WEEKS
// ═══════════════════════════════════════════════════════════════

final allWeeks = [
  WorkoutWeek(
    id: 'w1',
    weekNumber: 1,
    name: "Odin's Foundation",
    subtitle: 'Technique & Form',
    days: [_w1Day1, _w1Day2, _w1Day3, _w1Day4, _w1Day5, _w1Day6],
  ),
  WorkoutWeek(
    id: 'w2',
    weekNumber: 2,
    name: "Thor's Variation",
    subtitle: 'Volume & Range',
    days: [_w2Day1, _w2Day2, _w2Day3, _w2Day4, _w2Day5, _w2Day6],
  ),
  WorkoutWeek(
    id: 'w3',
    weekNumber: 3,
    name: "Tyr's Intensity",
    subtitle: 'Pause & Tempo',
    days: [_w3Day1, _w3Day2, _w3Day3, _w3Day4, _w3Day5, _w3Day6],
  ),
  WorkoutWeek(
    id: 'w4',
    weekNumber: 4,
    name: 'Fenrir Unleashed',
    subtitle: 'PRs & Drop Sets',
    days: [_w4Day1, _w4Day2, _w4Day3, _w4Day4, _w4Day5, _w4Day6],
  ),
];
