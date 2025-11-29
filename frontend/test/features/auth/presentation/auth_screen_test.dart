import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/config/l10n/app_localizations.dart';
import 'package:frontend/core/bloc/locale/locale_cubit.dart';
import 'package:frontend/core/bloc/locale/locale_state.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:frontend/features/auth/presentation/auth_screen.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_form.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_header.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

/// Mock for [AuthCubit].
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

/// Mock for [LocaleCubit].
class MockLocaleCubit extends MockCubit<LocaleState> implements LocaleCubit {}

/// Mock for [AppLocalizations].
class MockAppLocalizations extends AppLocalizations {
  MockAppLocalizations() : super('en');

  @override
  String get registrationSuccessful => 'Registration successful!';
  @override
  String get login => 'Login';
  @override
  String get signUp => 'Sign Up';
  @override
  String get register => 'Register';
  @override
  String get email => 'Email';
  @override
  String get password => 'Password';
  @override
  String get username => 'Username';
  String get enterUsername => 'Enter Username';
  @override
  String get dontHaveAccount => 'Don\'t have an account?';
  @override
  String get alreadyHaveAccount => 'Already have an account?';
  @override
  String get welcomeBack => 'Welcome Back!';
  @override
  String get createAccount => 'Create Account';
  @override
  String get enterCredentials => 'Enter Credentials';
  @override
  String get signUpToStart => 'Sign up to start';
  @override
  String get currentPrice => 'Current Price';
  @override
  String get live => 'LIVE';
  @override
  String get description => 'Description';
  @override
  String get recentBids => 'Recent Bids';
  @override
  String get placeBid => 'Place Bid';
  @override
  String get enterAmount => 'Enter Amount';
}

/// Fake delegate for [AppLocalizations].
class FakeAppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const FakeAppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(MockAppLocalizations());
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

/// Widget tests for [AuthScreen].
void main() {
  late MockAuthCubit mockAuthCubit;
  late MockLocaleCubit mockLocaleCubit;

  setUp(() {
    Intl.defaultLocale = 'en';
    mockAuthCubit = MockAuthCubit();
    mockLocaleCubit = MockLocaleCubit();
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: mockAuthCubit),
        BlocProvider<LocaleCubit>.value(value: mockLocaleCubit),
      ],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: [
          FakeAppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: AuthScreen(),
      ),
    );
  }

  testWidgets('renders AuthHeader and AuthForm', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(const AuthInitial(formData: AuthFormData()));
    when(
      () => mockLocaleCubit.state,
    ).thenReturn(const LocaleState(locale: Locale('en')));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(AuthHeader), findsOneWidget);
    expect(find.byType(AuthForm), findsOneWidget);
  });

  testWidgets('renders login form by default', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(const AuthInitial(formData: AuthFormData(isLogin: true)));
    when(
      () => mockLocaleCubit.state,
    ).thenReturn(const LocaleState(locale: Locale('en')));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Login'), findsOneWidget); // Button
    expect(
      find.textContaining('Sign Up', findRichText: true),
      findsOneWidget,
    ); // Switch button
  });

  testWidgets('renders register form when isLogin is false', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(const AuthInitial(formData: AuthFormData(isLogin: false)));
    when(
      () => mockLocaleCubit.state,
    ).thenReturn(const LocaleState(locale: Locale('en')));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Create Account'), findsOneWidget); // Header
    expect(find.text('Register'), findsOneWidget); // Button
    expect(
      find.textContaining('Login', findRichText: true),
      findsOneWidget,
    ); // Switch button
    expect(find.byType(TextFormField), findsNWidgets(3));
  });
}
