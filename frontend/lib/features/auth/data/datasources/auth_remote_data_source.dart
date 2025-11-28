import 'dart:convert';

import 'package:frontend/config.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> register(String email, String password, String username);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  String get _baseUrl => Config.baseUrl;

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> register(String email, String password, String username) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'username': username,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Registration failed');
    }
  }
}
