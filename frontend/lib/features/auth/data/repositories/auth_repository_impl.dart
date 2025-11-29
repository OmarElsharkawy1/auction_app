import '../../domain/entities/user.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of [IAuthRepository] that uses remote and local data sources.
class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    await localDataSource.cacheUser(userModel);
    return userModel;
  }

  @override
  Future<void> register(String email, String password, String username) async {
    await remoteDataSource.register(email, password, username);
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUser();
  }

  @override
  Future<User?> checkAuth() async {
    return await localDataSource.getLastUser();
  }
}
