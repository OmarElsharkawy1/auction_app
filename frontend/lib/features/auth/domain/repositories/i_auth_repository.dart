import 'package:frontend/features/auth/domain/entities/user.dart';

abstract class IAuthRepository {
  Future<User> login(String email, String password);
  Future<void> register(String email, String password, String username);
  Future<void> logout();
  Future<User?> checkAuth();
}
