import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/config/l10n/app_localizations.dart';
import 'package:frontend/core/bloc/locale/locale_cubit.dart';
import 'package:frontend/core/bloc/locale/locale_state.dart';
import 'package:frontend/features/auction/domain/entities/auction_item.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_state.dart';
import 'package:frontend/features/auction/presentatiom/auction_screen.dart';
import 'package:frontend/features/auction/presentatiom/widgets/auction_app_bar.dart';
import 'package:frontend/features/auction/presentatiom/widgets/auction_info.dart';
import 'package:frontend/features/auction/presentatiom/widgets/bid_input.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

/// Mock for [AuthCubit].
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

/// Mock for [AuctionCubit].
class MockAuctionCubit extends MockCubit<AuctionState>
    implements AuctionCubit {}

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

/// Widget tests for [AuctionScreen].
void main() {
  late MockAuthCubit mockAuthCubit;
  late MockAuctionCubit mockAuctionCubit;
  late MockLocaleCubit mockLocaleCubit;

  setUp(() {
    Intl.defaultLocale = 'en';
    mockAuthCubit = MockAuthCubit();
    mockAuctionCubit = MockAuctionCubit();
    mockLocaleCubit = MockLocaleCubit();
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: mockAuthCubit),
        BlocProvider<AuctionCubit>.value(value: mockAuctionCubit),
        BlocProvider<LocaleCubit>.value(value: mockLocaleCubit),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          FakeAppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const AuctionScreen(),
      ),
    );
  }

  final tAuctionItem = AuctionItem(
    id: 1,
    title: 'Test Item',
    description: 'Test Description',
    imageUrl: 'http://example.com/image.png',
    currentPrice: 100.0,
    highestBidder: 'testuser',
    bids: [Bid(user: 'testuser', amount: 100.0, timestamp: DateTime.now())],
  );

  testWidgets('renders loading indicator when state is loading', (
    tester,
  ) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(const AuthAuthenticated(token: 'token', username: 'user'));
    when(() => mockAuctionCubit.state).thenReturn(AuctionLoading());
    when(
      () => mockLocaleCubit.state,
    ).thenReturn(const LocaleState(locale: Locale('en')));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders auction details when state is loaded', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(const AuthAuthenticated(token: 'token', username: 'user'));
    when(() => mockAuctionCubit.state).thenReturn(AuctionLoaded(tAuctionItem));
    when(
      () => mockLocaleCubit.state,
    ).thenReturn(const LocaleState(locale: Locale('en')));

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
    });
    await tester.pump(); // Additional pump for image loading/rendering

    expect(find.byType(AuctionAppBar), findsOneWidget);
    expect(find.byType(AuctionInfo), findsOneWidget);
    // expect(find.byType(BidList), findsOneWidget);
    expect(find.byType(BidInput), findsOneWidget);
  });

  testWidgets('calls connect on init', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(const AuthAuthenticated(token: 'token', username: 'user'));
    when(() => mockAuctionCubit.state).thenReturn(AuctionLoading());
    when(
      () => mockLocaleCubit.state,
    ).thenReturn(const LocaleState(locale: Locale('en')));
    when(() => mockAuctionCubit.connect('token')).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    verify(() => mockAuctionCubit.connect('token')).called(1);
  });
}
