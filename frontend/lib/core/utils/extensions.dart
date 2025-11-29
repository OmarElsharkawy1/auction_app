import 'package:flutter/material.dart';
import 'package:frontend/config/l10n/app_localizations.dart';

/// Extension on [BuildContext] to easily access locale and localization resources.
extension Themes on BuildContext {
  Locale get currentLocale => Localizations.localeOf(this);
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
