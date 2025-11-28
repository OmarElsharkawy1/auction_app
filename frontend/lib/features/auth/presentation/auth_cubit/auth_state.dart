import 'package:equatable/equatable.dart';

class AuthFormData extends Equatable {
  final String email;
  final String password;
  final String username;
  final bool isLogin;

  const AuthFormData({
    this.email = '',
    this.password = '',
    this.username = '',
    this.isLogin = true,
  });

  AuthFormData copyWith({
    String? email,
    String? password,
    String? username,
    bool? isLogin,
  }) {
    return AuthFormData(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      isLogin: isLogin ?? this.isLogin,
    );
  }

  @override
  List<Object?> get props => [email, password, username, isLogin];
}

abstract class AuthState extends Equatable {
  final AuthFormData formData;

  const AuthState({this.formData = const AuthFormData()});

  @override
  List<Object?> get props => [formData];
}

class AuthInitial extends AuthState {
  const AuthInitial({super.formData});
}

class AuthLoading extends AuthState {
  const AuthLoading({super.formData});
}

class AuthAuthenticated extends AuthState {
  final String token;
  final String username;

  const AuthAuthenticated({
    required this.token,
    required this.username,
    super.formData,
  });

  @override
  List<Object?> get props => [token, username, formData];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({super.formData});
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message, {super.formData});

  @override
  List<Object?> get props => [message, formData];
}
