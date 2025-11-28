import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getLastUser();
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
