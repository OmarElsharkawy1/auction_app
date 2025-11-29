// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get enterCredentials =>
      'أدخل بيانات الاعتماد الخاصة بك للوصول إلى المزاد.';

  @override
  String get signUpToStart => 'سجل الآن لبدء المزايدة على العناصر الحصرية.';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'تسجيل';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get registrationSuccessful => 'تم التسجيل بنجاح! يرجى تسجيل الدخول.';

  @override
  String get currentPrice => 'السعر الحالي';

  @override
  String get live => 'مباشر';

  @override
  String get description => 'الوصف';

  @override
  String get recentBids => 'المزايدات الأخيرة';

  @override
  String get enterAmount => 'أدخل المبلغ';

  @override
  String get placeBid => 'ضع مزايدة';
}
