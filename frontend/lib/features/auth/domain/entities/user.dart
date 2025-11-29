import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the application.
class User extends Equatable {
  /// The user's unique username.
  final String username;

  /// The authentication token.
  final String token;

  const User({required this.username, required this.token});

  @override
  List<Object?> get props => [username, token];
}
