import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents the state of the application's locale.
class LocaleState extends Equatable {
  /// The current locale.
  final Locale locale;

  const LocaleState({required this.locale});

  /// Creates the initial state with English locale.
  factory LocaleState.initial() {
    return const LocaleState(locale: Locale('en'));
  }

  LocaleState copyWith({Locale? locale}) {
    return LocaleState(locale: locale ?? this.locale);
  }

  @override
  List<Object> get props => [locale];
}
