import 'package:flutter/material.dart';
import 'package:frontend/config/l10n/app_localizations.dart';

extension Themes on BuildContext {
  Locale get currentLocale => Localizations.localeOf(this);
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
