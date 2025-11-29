import 'package:frontend/features/auth/domain/entities/user.dart';

/// Interface for the authentication repository.
abstract class AuthRepository {
  /// Logs in a user with [email] and [password].
  Future<User> login(String email, String password);

  /// Registers a new user with [email], [password], and [username].
  Future<void> register(String email, String password, String username);

  /// Logs out the current user.
  Future<void> logout();

  /// Checks if a user is currently authenticated.
  Future<User?> checkAuth();
}
