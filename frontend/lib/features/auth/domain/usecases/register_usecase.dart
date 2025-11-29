import 'package:equatable/equatable.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/domain/repositories/i_auth_repository.dart';

/// Use case for registering a new user.
class RegisterUseCase implements UseCase<void, RegisterParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<void> call(RegisterParams params) async {
    return await repository.register(
      params.email,
      params.password,
      params.username,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String username;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  List<Object> get props => [email, password, username];
}
