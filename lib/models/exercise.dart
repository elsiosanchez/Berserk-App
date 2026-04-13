class Exercise {
  final String id;
  final String name;
  final int sets;
  final String reps;
  final String? tempo;
  final String? rest;
  final String? notes;
  final String? variation;

  const Exercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    this.tempo,
    this.rest,
    this.notes,
    this.variation,
  });
}
