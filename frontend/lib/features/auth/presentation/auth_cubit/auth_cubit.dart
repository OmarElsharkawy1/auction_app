import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/register_usecase.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.checkAuthUseCase,
  }) : super(const AuthInitial());

  void emailChanged(String value) {
    _updateForm(state.formData.copyWith(email: value));
  }

  void passwordChanged(String value) {
    _updateForm(state.formData.copyWith(password: value));
  }

  void usernameChanged(String value) {
    _updateForm(state.formData.copyWith(username: value));
  }

  void toggleAuthMode() {
    _updateForm(state.formData.copyWith(isLogin: !state.formData.isLogin));
  }

  void _updateForm(AuthFormData formData) {
    if (state is AuthInitial) {
      emit(AuthInitial(formData: formData));
    } else if (state is AuthUnauthenticated) {
      emit(AuthUnauthenticated(formData: formData));
    } else if (state is AuthError) {
      emit(AuthError((state as AuthError).message, formData: formData));
    } else {
      // Default to Unauthenticated if we are in a state where form updates shouldn't happen or are weird
      // But typically we are in Initial, Unauthenticated, or Error when typing.
      emit(AuthUnauthenticated(formData: formData));
    }
  }

  Future<void> submit() async {
    final formData = state.formData;
    if (formData.email.isEmpty || formData.password.isEmpty) return;
    if (!formData.isLogin && formData.username.isEmpty) return;

    emit(AuthLoading(formData: formData));

    try {
      if (formData.isLogin) {
        final user = await loginUseCase(
          LoginParams(email: formData.email, password: formData.password),
        );
        emit(
          AuthAuthenticated(
            token: user.token,
            username: user.username,
            formData: formData,
          ),
        );
      } else {
        await registerUseCase(
          RegisterParams(
            email: formData.email,
            password: formData.password,
            username: formData.username,
          ),
        );
        // On success register, switch to login mode? Or stay?
        // User logic was: "Registration successful! Please login." and switch to login.
        emit(AuthUnauthenticated(formData: formData.copyWith(isLogin: true)));
      }
    } catch (e) {
      emit(AuthError(e.toString(), formData: formData));
    }
  }

  Future<void> logout() async {
    await logoutUseCase(NoParams());
    emit(const AuthUnauthenticated());
  }

  Future<void> checkAuth() async {
    emit(const AuthLoading());
    try {
      // Check auth logic here
      // If failed:
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }
}
