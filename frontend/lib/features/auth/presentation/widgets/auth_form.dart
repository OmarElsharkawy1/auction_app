import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';

class AuthForm extends StatelessWidget {
  final bool isLogin;
  final AuthState state;

  const AuthForm({super.key, required this.isLogin, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onChanged: (value) => context.read<AuthCubit>().emailChanged(value),
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
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
          ),
      ],
    );
  }
}
