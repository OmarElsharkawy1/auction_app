import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

/// Mock for [AuthRepository].
class MockAuthRepository extends Mock implements AuthRepository {}

/// Tests for [LoginUseCase].
void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUseCase(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password';
  const tUser = User(username: 'testuser', token: 'testtoken');

  test('should get user from the repository', () async {
    // arrange
    when(
      () => mockAuthRepository.login(tEmail, tPassword),
    ).thenAnswer((_) async => tUser);

    // act
    final result = await usecase(
      const LoginParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result, tUser);
    verify(() => mockAuthRepository.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
