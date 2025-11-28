import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/components/snackbar.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) =>
              previous.formData.isLogin != current.formData.isLogin,
          builder: (context, state) {
            return Text(state.formData.isLogin ? 'Login' : 'Register');
          },
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          // Listener 1: Registration Success
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
                'Registration successful! Please login.',
              );
            },
          ),
          // Listener 2: Errors and Authentication
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) {
              if (current is AuthError) {
                return previous is! AuthError ||
                    previous.message != current.message;
              }
              if (current is AuthAuthenticated &&
                  previous is! AuthAuthenticated) {
                return true;
              }
              return false;
            },
            listener: (context, state) {
              if (state is AuthError) {
                AppSnackBar.showError(context, state.message);
              } else if (state is AuthAuthenticated) {
                context.read<AuctionCubit>().connect(state.token);
                context.go('/auction');
              }
            },
          ),
        ],
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final isLogin = state.formData.isLogin;
            final cubit = context.read<AuthCubit>();

            return Center(
              child: Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          initialValue: state.formData.email,
                          decoration: const InputDecoration(labelText: 'Email'),
                          onChanged: cubit.emailChanged,
                        ),
                        if (!isLogin)
                          TextFormField(
                            initialValue: state.formData.username,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            onChanged: cubit.usernameChanged,
                          ),
                        TextFormField(
                          initialValue: state.formData.password,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          onChanged: cubit.passwordChanged,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: cubit.submit,
                          child: Text(isLogin ? 'Login' : 'Register'),
                        ),
                        TextButton(
                          onPressed: cubit.toggleAuthMode,
                          child: Text(
                            isLogin
                                ? 'Create new account'
                                : 'I have an account',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
