import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';

/// Tests for [UserModel].
void main() {
  const tUserModel = UserModel(username: 'testuser', token: 'testtoken');

  test('should be a subclass of User entity', () async {
    expect(tUserModel, isA<User>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'user': {'username': 'testuser'},
        'token': 'testtoken',
      };
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      expect(result, tUserModel);
    });
  });
}
