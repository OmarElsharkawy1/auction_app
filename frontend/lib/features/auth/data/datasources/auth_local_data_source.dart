import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interface for local data storage of authentication information.
abstract class AuthLocalDataSource {
  /// Caches the [user] locally.
  Future<void> cacheUser(UserModel user);

  /// Retrieves the last cached user, if any.
  Future<UserModel?> getLastUser();

  /// Clears the cached user data.
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString('token', user.token);
    await sharedPreferences.setString('username', user.username);
  }

  @override
  Future<UserModel?> getLastUser() async {
    final token = sharedPreferences.getString('token');
    final username = sharedPreferences.getString('username');
    if (token != null && username != null) {
      return UserModel(username: username, token: token);
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove('token');
    await sharedPreferences.remove('username');
  }
}
