import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../providers/active_workout_provider.dart';
import '../l10n/app_strings.dart';

class RestTimer extends ConsumerStatefulWidget {
  const RestTimer({super.key});

  @override
  ConsumerState<RestTimer> createState() => _RestTimerState();
}

class _RestTimerState extends ConsumerState<RestTimer> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTicking();
  }

  void _startTicking() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      ref.read(activeWorkoutProvider.notifier).tickRestTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activeWorkoutProvider);

    if (!state.isRestTimerActive) {
      _timer?.cancel();
      return const SizedBox.shrink();
    }

    final remaining = state.restSecondsRemaining;
    final total = state.restSecondsTotal;
    final progress = total > 0 ? remaining / total : 0.0;
    final minutes = remaining ~/ 60;
    final seconds = remaining % 60;

    return Container(
      color: Colors.black.withOpacity(0.85),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.rest, style: BerserkTypography.h3.copyWith(
              color: BerserkColors.textSecondary,
              letterSpacing: 4,
            )),
            const SizedBox(height: 24),
            // Circular timer
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: _CircularTimerPainter(
                  progress: progress,
                  color: BerserkColors.accent,
                  bgColor: BerserkColors.card2,
                ),
                child: Center(
                  child: Text(
                    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    style: BerserkTypography.timerDisplay,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Skip button
            GestureDetector(
              onTap: () {
                ref.read(activeWorkoutProvider.notifier).skipRestTimer();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                decoration: BoxDecoration(
                  color: BerserkColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  S.skipRest,
                  style: BerserkTypography.h3.copyWith(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // +15s / -15s buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _adjustButton('-15s', -15),
                const SizedBox(width: 16),
                _adjustButton('+15s', 15),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _adjustButton(String label, int seconds) {
    return GestureDetector(
      onTap: () {
        final state = ref.read(activeWorkoutProvider);
        final newRemaining = (state.restSecondsRemaining + seconds).clamp(0, 600);
        ref.read(activeWorkoutProvider.notifier).skipRestTimer();
        if (newRemaining > 0) {
          ref.read(activeWorkoutProvider.notifier).startRestTimer('${newRemaining}s');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: BerserkColors.card2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: BerserkTypography.caption.copyWith(
            color: BerserkColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CircularTimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color bgColor;

  _CircularTimerPainter({
    required this.progress,
    required this.color,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 6.0;

    // Background circle
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularTimerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
