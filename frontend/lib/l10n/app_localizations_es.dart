// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get enterCredentials =>
      'Ingrese sus credenciales para acceder a la subasta.';

  @override
  String get signUpToStart =>
      'Regístrese para comenzar a pujar por artículos exclusivos.';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta? ';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get signUp => 'Regístrate';

  @override
  String get registrationSuccessful =>
      '¡Registro exitoso! Por favor inicie sesión.';

  @override
  String get currentPrice => 'Precio actual';

  @override
  String get live => 'EN VIVO';

  @override
  String get description => 'Descripción';

  @override
  String get recentBids => 'Pujas recientes';

  @override
  String get enterAmount => 'Ingrese cantidad';

  @override
  String get placeBid => 'Hacer puja';
}
