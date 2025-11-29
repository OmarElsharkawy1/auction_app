// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get createAccount => 'Create Account';

  @override
  String get enterCredentials =>
      'Enter your credentials to access the auction.';

  @override
  String get signUpToStart => 'Sign up to start bidding on exclusive items.';

  @override
  String get username => 'Username';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get signUp => 'Sign Up';

  @override
  String get registrationSuccessful =>
      'Registration successful! Please log in.';

  @override
  String get currentPrice => 'Current Price';

  @override
  String get live => 'LIVE';

  @override
  String get description => 'Description';

  @override
  String get recentBids => 'Recent Bids';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get placeBid => 'Place Bid';
}
