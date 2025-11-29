import 'package:frontend/features/auth/domain/entities/user.dart';

/// A data model representing a user, extending [User].
///
/// Includes methods for JSON serialization and deserialization.
class UserModel extends User {
  const UserModel({required super.username, required super.token});

  /// Creates a [UserModel] from a JSON map.
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
