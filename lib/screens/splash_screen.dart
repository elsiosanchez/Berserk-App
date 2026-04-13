import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../l10n/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      context.go('/workouts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BerserkColors.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: BerserkColors.card,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.pets,
                size: 64,
                color: BerserkColors.accent,
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.8, 0.8), duration: 600.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 24),
            Text(
              S.appName,
              style: BerserkTypography.h1.copyWith(
                letterSpacing: 8,
                fontSize: 36,
              ),
            )
                .animate(delay: 400.ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.3, duration: 500.ms, curve: Curves.easeOut),
            const SizedBox(height: 8),
            Text(
              S.unleashTheWarrior,
              style: BerserkTypography.caption.copyWith(
                letterSpacing: 4,
                color: BerserkColors.textSecondary,
              ),
            )
                .animate(delay: 700.ms)
                .fadeIn(duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
