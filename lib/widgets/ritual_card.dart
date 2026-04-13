import 'package:flutter/material.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../models/workout_day.dart';
import '../l10n/app_strings.dart';

class RitualCard extends StatelessWidget {
  const RitualCard({
    super.key,
    required this.day,
    required this.weekName,
    required this.onTap,
    this.isCompleted = false,
  });

  final WorkoutDay day;
  final String weekName;
  final VoidCallback onTap;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: BerserkColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: day.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                weekName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: day.color,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Day name
            Text(day.name, style: BerserkTypography.h2),
            const SizedBox(height: 4),
            Text(
              S.get(day.subtitle),
              style: BerserkTypography.bodyText,
            ),
            const SizedBox(height: 16),
            // Stats row
            Row(
              children: [
                _infoChip(Icons.fitness_center, '${day.totalExercises} ${S.exercises}'),
                const SizedBox(width: 12),
                _infoChip(Icons.timer_outlined, day.estimatedTime),
                const SizedBox(width: 12),
                _infoChip(Icons.layers_outlined, '${day.totalSets} ${S.sets}'),
              ],
            ),
            const SizedBox(height: 16),
            // CTA button
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isCompleted ? BerserkColors.success : BerserkColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    isCompleted ? S.completed : S.startWorkout,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: BerserkColors.textTertiary),
        const SizedBox(width: 4),
        Text(text, style: BerserkTypography.caption),
      ],
    );
  }
}
