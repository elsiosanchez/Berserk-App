import 'package:flutter/material.dart';
import '../theme/berserk_colors.dart';
import '../models/workout_section.dart';
import '../l10n/app_strings.dart';

class SectionRow extends StatelessWidget {
  const SectionRow({super.key, required this.section});

  final WorkoutSection section;

  static const _homeAltColor = Color(0xFFE67E22);

  Color get _dotColor {
    switch (section.type) {
      case SectionType.warmup:
        return BerserkColors.success;
      case SectionType.gym:
        return BerserkColors.accent;
      case SectionType.homeAlt:
        return _homeAltColor;
    }
  }

  String get _label {
    switch (section.type) {
      case SectionType.warmup:
        return S.warmup;
      case SectionType.gym:
        return S.gymRoutine;
      case SectionType.homeAlt:
        return S.homeAlt;
    }
  }

  String? get _sublabel {
    switch (section.type) {
      case SectionType.warmup:
        return S.warmupSub;
      case SectionType.gym:
        return null;
      case SectionType.homeAlt:
        return S.homeAltSub;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _dotColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Divider(
                  color: BerserkColors.card2,
                  thickness: 0.5,
                ),
              ),
            ],
          ),
          if (_sublabel != null)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 2),
              child: Text(
                _sublabel!,
                style: TextStyle(
                  fontSize: 11,
                  color: _dotColor.withOpacity(0.6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
