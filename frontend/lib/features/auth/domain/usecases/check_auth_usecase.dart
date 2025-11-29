import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';
import 'package:frontend/features/auth/domain/repositories/i_auth_repository.dart';

/// Use case for checking the current authentication status.
class CheckAuthUseCase implements UseCase<User?, NoParams> {
  final IAuthRepository repository;

  CheckAuthUseCase(this.repository);

  @override
  Future<User?> call(NoParams params) async {
    return await repository.checkAuth();
  }
}
