import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              'Registration successful! Please log in.',
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
                    const Icon(
                      Icons.gavel_rounded,
                      size: 64,
                      color: Color(0xFF2962FF),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      isLogin ? 'Welcome Back' : 'Create Account',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isLogin
                          ? 'Enter your credentials to access the auction.'
                          : 'Sign up to start bidding on exclusive items.',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 48),
                    if (!isLogin) ...[
                      TextFormField(
                        key: const ValueKey('username'),
                        initialValue: state.formData.username,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        onChanged: (value) =>
                            context.read<AuthCubit>().usernameChanged(value),
                      ),
                      const SizedBox(height: 20),
                    ],
                    TextFormField(
                      key: const ValueKey('email'),
                      initialValue: state.formData.email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      onChanged: (value) =>
                          context.read<AuthCubit>().emailChanged(value),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const ValueKey('password'),
                      initialValue: state.formData.password,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      onChanged: (value) =>
                          context.read<AuthCubit>().passwordChanged(value),
                    ),
                    const SizedBox(height: 32),
                    if (state is AuthLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().submit();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(isLogin ? 'Login' : 'Register'),
                      ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        context.read<AuthCubit>().toggleAuthMode();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: isLogin
                              ? 'Don\'t have an account? '
                              : 'Already have an account? ',
                          style: TextStyle(color: Colors.grey[600]),
                          children: [
                            TextSpan(
                              text: isLogin ? 'Sign Up' : 'Login',
                              style: const TextStyle(
                                color: Color(0xFF2962FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
