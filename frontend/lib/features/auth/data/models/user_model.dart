import 'package:frontend/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.username, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(username: json['user']['username'], token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {'username': username},
      'token': token,
    };
  }
}
