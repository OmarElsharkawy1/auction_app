import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/domain/repositories/i_auth_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final IAuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return await repository.logout();
  }
}
