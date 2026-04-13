import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../l10n/app_strings.dart';
import '../providers/locale_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    return Scaffold(
      backgroundColor: BerserkColors.bg,
      appBar: AppBar(
        title: Text(S.profile, style: BerserkTypography.h3),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: BerserkColors.card,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 40,
                color: BerserkColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(S.vikingWarrior, style: BerserkTypography.h3),
            const SizedBox(height: 4),
            Text(S.profileComingSoon, style: BerserkTypography.bodyText),
          ],
        ),
      ),
    );
  }
}
