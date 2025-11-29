import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

/// Mock for [AuthRemoteDataSource].
class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

/// Mock for [AuthLocalDataSource].
class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

/// Tests for [AuthRepositoryImpl].
void main() {
  late AuthRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tUsername = 'testuser';
  const tEmail = 'test@example.com';
  const tPassword = 'password';
  const tToken = 'testtoken';
  const tUserModel = UserModel(username: tUsername, token: tToken);
  const User tUser = tUserModel;

  group('login', () {
    test(
      'should return user when remote call is successful and cache it',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.login(tEmail, tPassword),
        ).thenAnswer((_) async => tUserModel);
        when(
          () => mockLocalDataSource.cacheUser(tUserModel),
        ).thenAnswer((_) async => {});

        // act
        final result = await repository.login(tEmail, tPassword);

        // assert
        expect(result, tUser);
        verify(() => mockRemoteDataSource.login(tEmail, tPassword)).called(1);
        verify(() => mockLocalDataSource.cacheUser(tUserModel)).called(1);
      },
    );
  });

  group('register', () {
    test('should call remote register', () async {
      // arrange
      when(
        () => mockRemoteDataSource.register(tEmail, tPassword, tUsername),
      ).thenAnswer((_) async => {});

      // act
      await repository.register(tEmail, tPassword, tUsername);

      // assert
      verify(
        () => mockRemoteDataSource.register(tEmail, tPassword, tUsername),
      ).called(1);
    });
  });

  group('logout', () {
    test('should clear local user', () async {
      // arrange
      when(() => mockLocalDataSource.clearUser()).thenAnswer((_) async => {});

      // act
      await repository.logout();

      // assert
      verify(() => mockLocalDataSource.clearUser()).called(1);
    });
  });

  group('checkAuth', () {
    test('should return user from local storage', () async {
      // arrange
      when(
        () => mockLocalDataSource.getLastUser(),
      ).thenAnswer((_) async => tUserModel);

      // act
      final result = await repository.checkAuth();

      // assert
      expect(result, tUser);
      verify(() => mockLocalDataSource.getLastUser()).called(1);
    });
  });
}
