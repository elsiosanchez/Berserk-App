import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_strings.dart';

class LocaleNotifier extends StateNotifier<AppLocale> {
  LocaleNotifier() : super(AppLocale.es) {
    S.setLocale(AppLocale.es);
  }

  void setLocale(AppLocale locale) {
    S.setLocale(locale);
    state = locale;
  }

  void toggle() {
    final next = state == AppLocale.es ? AppLocale.en : AppLocale.es;
    setLocale(next);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, AppLocale>(
  (ref) => LocaleNotifier(),
);
