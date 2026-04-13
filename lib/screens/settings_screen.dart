import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/berserk_colors.dart';
import '../theme/berserk_typography.dart';
import '../l10n/app_strings.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: BerserkColors.bg,
      appBar: AppBar(
        title: Text(S.settings, style: BerserkTypography.h3),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language selector
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: BerserkColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.language, color: BerserkColors.textSecondary),
              title: Text(S.language, style: BerserkTypography.h3.copyWith(fontSize: 15)),
              trailing: GestureDetector(
                onTap: () => _showLanguageSelector(context, ref, currentLocale),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: BerserkColors.card2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentLocale == AppLocale.es ? 'ES' : 'EN',
                        style: BerserkTypography.h3.copyWith(
                          fontSize: 13,
                          color: BerserkColors.accent,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.expand_more, size: 16, color: BerserkColors.accent),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildSettingsTile(S.notifications, Icons.notifications_outlined),
          _buildSettingsTile(S.units, Icons.straighten_outlined),
          _buildSettingsTile(S.exportData, Icons.file_download_outlined),
          _buildSettingsTile(S.about, Icons.info_outline),
        ],
      ),
    );
  }

  void _showLanguageSelector(BuildContext context, WidgetRef ref, AppLocale current) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BerserkColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: BerserkColors.textTertiary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(S.language, style: BerserkTypography.h2),
                const SizedBox(height: 16),
                _languageOption(ctx, ref, AppLocale.es, S.spanish, current == AppLocale.es),
                const SizedBox(height: 8),
                _languageOption(ctx, ref, AppLocale.en, S.english, current == AppLocale.en),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _languageOption(
    BuildContext context,
    WidgetRef ref,
    AppLocale locale,
    String label,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        ref.read(localeProvider.notifier).setLocale(locale);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? BerserkColors.accent.withOpacity(0.1)
              : BerserkColors.card2,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: BerserkColors.accent, width: 1)
              : null,
        ),
        child: Row(
          children: [
            Text(
              locale == AppLocale.es ? '🇪🇸' : '🇺🇸',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: BerserkTypography.h3.copyWith(fontSize: 15)),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: BerserkColors.accent, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: BerserkColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: BerserkColors.textSecondary),
        title: Text(title, style: BerserkTypography.h3.copyWith(fontSize: 15)),
        trailing: const Icon(
          Icons.chevron_right,
          color: BerserkColors.textTertiary,
        ),
      ),
    );
  }
}
