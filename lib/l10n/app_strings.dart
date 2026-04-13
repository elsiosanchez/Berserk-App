enum AppLocale { es, en }

class S {
  S._();

  static AppLocale _locale = AppLocale.es;

  static AppLocale get locale => _locale;

  static void setLocale(AppLocale l) => _locale = l;

  static String get(String key) {
    final map = _locale == AppLocale.es ? _es : _en;
    return map[key] ?? _en[key] ?? key;
  }

  // ─── Strings keys ───

  // General
  static String get appName => get('appName');
  static String get unleashTheWarrior => get('unleashTheWarrior');
  static String get done => get('done');
  static String get cancel => get('cancel');
  static String get confirm => get('confirm');
  static String get back => get('back');
  static String get restDay => get('restDay');
  static String get restDayMessage => get('restDayMessage');

  // Home
  static String get todaysRitual => get('todaysRitual');
  static String get thisWeek => get('thisWeek');
  static String get weeklyProgress => get('weeklyProgress');
  static String get selectWeek => get('selectWeek');
  static String get workouts => get('workouts');
  static String get rate => get('rate');
  static String get streak => get('streak');
  static String get today => get('today');

  // Workout
  static String get startWorkout => get('startWorkout');
  static String get completed => get('completed');
  static String get markDone => get('markDone');
  static String get exercises => get('exercises');
  static String get sets => get('sets');
  static String get reps => get('reps');

  // Active Workout
  static String get finish => get('finish');
  static String get rest => get('rest');
  static String get skipRest => get('skipRest');
  static String get quitWorkout => get('quitWorkout');
  static String get quitMessage => get('quitMessage');
  static String get keepGoing => get('keepGoing');
  static String get quit => get('quit');
  static String get noWorkoutLoaded => get('noWorkoutLoaded');
  static String get goBack => get('goBack');
  static String get swipePrevious => get('swipePrevious');
  static String get swipeNext => get('swipeNext');

  // Summary
  static String get workoutComplete => get('workoutComplete');
  static String get duration => get('duration');
  static String get setsDone => get('setsDone');
  static String get totalVolume => get('totalVolume');

  // Sections
  static String get warmup => get('warmup');
  static String get warmupSub => get('warmupSub');
  static String get gymRoutine => get('gymRoutine');
  static String get homeAlt => get('homeAlt');
  static String get homeAltSub => get('homeAltSub');

  // Muscle groups
  static String get chestTriceps => get('chestTriceps');
  static String get backBiceps => get('backBiceps');
  static String get quadsHams => get('quadsHams');
  static String get shouldersTraps => get('shouldersTraps');
  static String get bicepsTriceps => get('bicepsTriceps');
  static String get legsCore => get('legsCore');

  // Profile
  static String get profile => get('profile');
  static String get vikingWarrior => get('vikingWarrior');
  static String get profileComingSoon => get('profileComingSoon');

  // Progress
  static String get progress => get('progress');
  static String get progressComingSoon => get('progressComingSoon');

  // Nutrition
  static String get nutrition => get('nutrition');
  static String get nutritionComingSoon => get('nutritionComingSoon');

  // Checkpoints
  static String get checkpoints => get('checkpoints');
  static String get checkpointsComingSoon => get('checkpointsComingSoon');

  // Settings
  static String get settings => get('settings');
  static String get notifications => get('notifications');
  static String get units => get('units');
  static String get exportData => get('exportData');
  static String get about => get('about');
  static String get language => get('language');
  static String get spanish => get('spanish');
  static String get english => get('english');

  // Days
  static String get mon => get('mon');
  static String get tue => get('tue');
  static String get wed => get('wed');
  static String get thu => get('thu');
  static String get fri => get('fri');
  static String get sat => get('sat');

  static List<String> get dayLabels => [mon, tue, wed, thu, fri, sat];

  // ─── Spanish ───

  static const _es = <String, String>{
    'appName': 'BERSERK',
    'unleashTheWarrior': 'DESATA AL GUERRERO',
    'done': 'Listo',
    'cancel': 'Cancelar',
    'confirm': 'Confirmar',
    'back': 'Volver',
    'restDay': 'Día de Descanso',
    'restDayMessage': 'La recuperación es parte del camino, guerrero.',

    // Home
    'todaysRitual': 'Ritual de Hoy',
    'thisWeek': 'Esta Semana',
    'weeklyProgress': 'Progreso Semanal',
    'selectWeek': 'Seleccionar Semana',
    'workouts': 'Entrenos',
    'rate': 'Ratio',
    'streak': 'Racha',
    'today': 'HOY',

    // Workout
    'startWorkout': 'Iniciar Entreno',
    'completed': 'Completado',
    'markDone': 'Marcar Hecho',
    'exercises': 'ejercicios',
    'sets': 'series',
    'reps': 'reps',

    // Active
    'finish': 'Terminar',
    'rest': 'DESCANSO',
    'skipRest': 'Saltar Descanso',
    'quitWorkout': '¿Abandonar Entreno?',
    'quitMessage': 'Tu progreso se perderá.',
    'keepGoing': 'Seguir',
    'quit': 'Abandonar',
    'noWorkoutLoaded': 'No hay entreno cargado',
    'goBack': 'Volver',
    'swipePrevious': 'Desliza al anterior',
    'swipeNext': 'Desliza al siguiente',

    // Summary
    'workoutComplete': '¡Entreno Completado!',
    'duration': 'Duración',
    'setsDone': 'Series Hechas',
    'totalVolume': 'Volumen Total',

    // Sections
    'warmup': 'Calentamiento',
    'warmupSub': 'Realiza antes de empezar',
    'gymRoutine': 'Rutina en Gym',
    'homeAlt': 'Alternativa en Casa / Parque',
    'homeAltSub': 'Si no podés ir al gym',

    // Muscle groups
    'chestTriceps': 'Pecho y Tríceps',
    'backBiceps': 'Espalda y Bíceps',
    'quadsHams': 'Cuádriceps e Isquios',
    'shouldersTraps': 'Hombros y Trapecios',
    'bicepsTriceps': 'Bíceps y Tríceps',
    'legsCore': 'Piernas y Core',

    // Profile
    'profile': 'Perfil',
    'vikingWarrior': 'Guerrero Vikingo',
    'profileComingSoon': 'Configuración de perfil próximamente',

    // Progress
    'progress': 'Progreso',
    'progressComingSoon': 'Seguimiento de progreso próximamente',

    // Nutrition
    'nutrition': 'Nutrición',
    'nutritionComingSoon': 'Seguimiento nutricional próximamente',

    // Checkpoints
    'checkpoints': 'Checkpoints',
    'checkpointsComingSoon': 'Checkpoints semanales',

    // Settings
    'settings': 'Ajustes',
    'notifications': 'Notificaciones',
    'units': 'Unidades',
    'exportData': 'Exportar Datos',
    'about': 'Acerca de',
    'language': 'Idioma',
    'spanish': 'Español',
    'english': 'English',

    // Days
    'mon': 'Lun',
    'tue': 'Mar',
    'wed': 'Mié',
    'thu': 'Jue',
    'fri': 'Vie',
    'sat': 'Sáb',
  };

  // ─── English ───

  static const _en = <String, String>{
    'appName': 'BERSERK',
    'unleashTheWarrior': 'UNLEASH THE WARRIOR',
    'done': 'Done',
    'cancel': 'Cancel',
    'confirm': 'Confirm',
    'back': 'Go Back',
    'restDay': 'Rest Day',
    'restDayMessage': 'Recovery is part of the journey, warrior.',

    // Home
    'todaysRitual': "Today's Ritual",
    'thisWeek': 'This Week',
    'weeklyProgress': 'Weekly Progress',
    'selectWeek': 'Select Week',
    'workouts': 'Workouts',
    'rate': 'Rate',
    'streak': 'Streak',
    'today': 'TODAY',

    // Workout
    'startWorkout': 'Start Workout',
    'completed': 'Completed',
    'markDone': 'Mark Done',
    'exercises': 'exercises',
    'sets': 'sets',
    'reps': 'reps',

    // Active
    'finish': 'Finish',
    'rest': 'REST',
    'skipRest': 'Skip Rest',
    'quitWorkout': 'Quit Workout?',
    'quitMessage': 'Your progress will be lost.',
    'keepGoing': 'Keep Going',
    'quit': 'Quit',
    'noWorkoutLoaded': 'No workout loaded',
    'goBack': 'Go Back',
    'swipePrevious': 'Swipe for previous',
    'swipeNext': 'Swipe for next',

    // Summary
    'workoutComplete': 'Workout Complete!',
    'duration': 'Duration',
    'setsDone': 'Sets Done',
    'totalVolume': 'Total Volume',

    // Sections
    'warmup': 'Warm-up',
    'warmupSub': 'Do before starting',
    'gymRoutine': 'Gym Routine',
    'homeAlt': 'Home / Park Alternative',
    'homeAltSub': "If you can't go to the gym",

    // Muscle groups
    'chestTriceps': 'Chest & Triceps',
    'backBiceps': 'Back & Biceps',
    'quadsHams': 'Quads & Hamstrings',
    'shouldersTraps': 'Shoulders & Traps',
    'bicepsTriceps': 'Biceps & Triceps',
    'legsCore': 'Legs & Core',

    // Profile
    'profile': 'Profile',
    'vikingWarrior': 'Viking Warrior',
    'profileComingSoon': 'Profile setup coming soon',

    // Progress
    'progress': 'Progress',
    'progressComingSoon': 'Progress tracking coming soon',

    // Nutrition
    'nutrition': 'Nutrition',
    'nutritionComingSoon': 'Nutrition tracking coming soon',

    // Checkpoints
    'checkpoints': 'Checkpoints',
    'checkpointsComingSoon': 'Weekly checkpoints',

    // Settings
    'settings': 'Settings',
    'notifications': 'Notifications',
    'units': 'Units',
    'exportData': 'Export Data',
    'about': 'About',
    'language': 'Language',
    'spanish': 'Español',
    'english': 'English',

    // Days
    'mon': 'Mon',
    'tue': 'Tue',
    'wed': 'Wed',
    'thu': 'Thu',
    'fri': 'Fri',
    'sat': 'Sat',
  };
}
