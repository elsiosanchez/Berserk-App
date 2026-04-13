import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../l10n/app_strings.dart';
import '../providers/locale_provider.dart';

class CheckpointScreen extends ConsumerWidget {
  const CheckpointScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    return Scaffold(
      backgroundColor: BerserkColors.bg,
      appBar: AppBar(
        title: Text(S.checkpoints, style: BerserkTypography.h3),
      ),
      body: Center(
        child: Text(
          S.checkpointsComingSoon,
          style: BerserkTypography.bodyText,
        ),
      ),
    );
  }
}
