import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/components/language_switcher.dart';
import 'package:frontend/core/utils/extensions.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_form.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_header.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_switch.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/snackbar.dart';
import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) {
            return previous is AuthLoading &&
                current is AuthUnauthenticated &&
                current.formData.isLogin &&
                !previous.formData.isLogin;
          },
          listener: (context, state) {
            AppSnackBar.showSuccess(
              context,
              context.l10n.registrationSuccessful,
            );
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) {
            return current is AuthError &&
                (previous is! AuthError || previous.message != current.message);
          },
          listener: (context, state) {
            if (state is AuthError) {
              AppSnackBar.showError(context, state.message);
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) => current is AuthAuthenticated,
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.go('/auction');
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [LanguageSwitcher(), SizedBox(width: 16)],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final isLogin = state.formData.isLogin;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthHeader(isLogin: isLogin),
                    const SizedBox(height: 48),
                    AuthForm(isLogin: isLogin, state: state),
                    const SizedBox(height: 24),
                    AuthSwitch(
                      isLogin: isLogin,
                      onToggle: () {
                        context.read<AuthCubit>().toggleAuthMode();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
