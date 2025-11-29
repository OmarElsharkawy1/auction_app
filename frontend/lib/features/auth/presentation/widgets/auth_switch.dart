import 'package:flutter/material.dart';
import 'package:frontend/core/utils/extensions.dart';

/// A button to toggle between login and registration modes.
class AuthSwitch extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onToggle;

  const AuthSwitch({super.key, required this.isLogin, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onToggle,
      child: RichText(
        text: TextSpan(
          text: isLogin
              ? context.l10n.dontHaveAccount
              : context.l10n.alreadyHaveAccount,
          style: TextStyle(color: Colors.grey[600]),
          children: [
            TextSpan(
              text: isLogin ? context.l10n.signUp : context.l10n.login,
              style: const TextStyle(
                color: Color(0xFF2962FF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
