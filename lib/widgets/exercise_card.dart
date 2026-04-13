import 'package:flutter/material.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../models/exercise.dart';
import '../l10n/app_strings.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.exercise,
    this.accentColor,
  });

  final Exercise exercise;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Left accent bar
          Container(
            width: 3,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor ?? BerserkColors.textSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: BerserkTypography.h3.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _badge('${exercise.sets} ${S.sets}'),
                    const SizedBox(width: 6),
                    _badge('${exercise.reps} ${S.reps}'),
                    if (exercise.rest != null && exercise.rest!.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      _badge(exercise.rest!),
                    ],
                  ],
                ),
                if (exercise.tempo != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Tempo: ${exercise.tempo}',
                    style: BerserkTypography.caption.copyWith(
                      color: BerserkColors.amber,
                    ),
                  ),
                ],
                if (exercise.notes != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    exercise.notes!,
                    style: BerserkTypography.caption,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: BerserkColors.card2.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: BerserkColors.textSecondary,
        ),
      ),
    );
  }
}
