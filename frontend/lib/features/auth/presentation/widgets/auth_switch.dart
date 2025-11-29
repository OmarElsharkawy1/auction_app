import 'package:flutter/material.dart';

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
    );
  }
}
