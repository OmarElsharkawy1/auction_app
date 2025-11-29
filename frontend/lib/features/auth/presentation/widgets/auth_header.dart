import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final bool isLogin;

  const AuthHeader({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.gavel_rounded, size: 64, color: Color(0xFF2962FF)),
        const SizedBox(height: 32),
        Text(
          isLogin ? 'Welcome Back' : 'Create Account',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
      ],
    );
  }
}
