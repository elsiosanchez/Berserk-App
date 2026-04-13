import 'package:flutter/material.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';

class StatBox extends StatelessWidget {
  const StatBox({
    super.key,
    required this.value,
    required this.label,
    this.color,
  });

  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: BerserkTypography.statNumber.copyWith(
              color: color ?? BerserkColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: BerserkTypography.caption),
        ],
      ),
    );
  }
}
