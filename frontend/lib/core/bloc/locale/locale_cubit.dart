import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locale_state.dart';

/// Manages the application's locale state.
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState.initial());

  /// Changes the application's locale to the provided [locale].
  void changeLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
