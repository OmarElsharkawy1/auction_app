import 'package:flutter/material.dart';
import 'package:frontend/core/utils/extensions.dart';

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
          isLogin ? context.l10n.welcomeBack : context.l10n.createAccount,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isLogin ? context.l10n.enterCredentials : context.l10n.signUpToStart,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
