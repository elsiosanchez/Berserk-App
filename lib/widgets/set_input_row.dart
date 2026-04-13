import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../providers/active_workout_provider.dart';

class SetInputRow extends StatelessWidget {
  const SetInputRow({
    super.key,
    required this.setIndex,
    required this.data,
    required this.onWeightChanged,
    required this.onRepsChanged,
    required this.onCompleted,
  });

  final int setIndex;
  final ActiveSetData data;
  final ValueChanged<double> onWeightChanged;
  final ValueChanged<int> onRepsChanged;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: data.completed
            ? BerserkColors.success.withOpacity(0.08)
            : BerserkColors.card,
        borderRadius: BorderRadius.circular(12),
        border: data.completed
            ? Border.all(color: BerserkColors.success.withOpacity(0.2))
            : null,
      ),
      child: Row(
        children: [
          // Set number
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: data.completed ? BerserkColors.success : BerserkColors.card2,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: data.completed
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text(
                      '${setIndex + 1}',
                      style: BerserkTypography.h3.copyWith(
                        fontSize: 13,
                        color: BerserkColors.textSecondary,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Weight input
          Expanded(
            child: _NumberInput(
              label: 'kg',
              initialValue: data.weight > 0 ? data.weight.toString() : '',
              isDecimal: true,
              enabled: !data.completed,
              onChanged: (val) {
                final weight = double.tryParse(val) ?? 0;
                onWeightChanged(weight);
              },
            ),
          ),
          const SizedBox(width: 10),
          // Reps input
          Expanded(
            child: _NumberInput(
              label: 'reps',
              initialValue: data.reps > 0 ? data.reps.toString() : '',
              isDecimal: false,
              enabled: !data.completed,
              onChanged: (val) {
                final reps = int.tryParse(val) ?? 0;
                onRepsChanged(reps);
              },
            ),
          ),
          const SizedBox(width: 10),
          // Complete button
          GestureDetector(
            onTap: onCompleted,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: data.completed ? BerserkColors.success : BerserkColors.accent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                data.completed ? Icons.undo : Icons.check,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberInput extends StatelessWidget {
  const _NumberInput({
    required this.label,
    required this.initialValue,
    required this.isDecimal,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final String initialValue;
  final bool isDecimal;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: enabled ? BerserkColors.card2 : BerserkColors.card2.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              enabled: enabled,
              keyboardType: TextInputType.numberWithOptions(decimal: isDecimal),
              inputFormatters: [
                if (isDecimal)
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                else
                  FilteringTextInputFormatter.digitsOnly,
              ],
              style: BerserkTypography.h3.copyWith(fontSize: 15),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChanged,
            ),
          ),
          Text(
            label,
            style: BerserkTypography.caption.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
