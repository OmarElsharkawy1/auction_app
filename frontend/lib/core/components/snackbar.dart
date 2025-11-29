import 'package:flutter/material.dart';

/// A utility class for showing custom SnackBars.
class AppSnackBar {
  /// Shows a success SnackBar with a green background and check icon.
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context,
      message,
      color: Colors.green.shade600,
      icon: Icons.check_circle_outline,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context,
      message,
      color: Colors.red.shade700,
      icon: Icons.error_outline,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context,
      message,
      color: Colors.orange.shade800,
      icon: Icons.warning_amber_rounded,
      duration: duration,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required Color color,
    required IconData icon,
    required Duration duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: color,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
