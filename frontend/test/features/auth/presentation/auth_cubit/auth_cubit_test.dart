import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';
import 'package:frontend/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/register_usecase.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:mocktail/mocktail.dart';

/// Mock for [LoginUseCase].
class MockLoginUseCase extends Mock implements LoginUseCase {}

/// Mock for [RegisterUseCase].
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

/// Mock for [LogoutUseCase].
class MockLogoutUseCase extends Mock implements LogoutUseCase {}

/// Mock for [CheckAuthUseCase].
class MockCheckAuthUseCase extends Mock implements CheckAuthUseCase {}

/// Tests for [AuthCubit].
void main() {
  late AuthCubit cubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockCheckAuthUseCase mockCheckAuthUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockCheckAuthUseCase = MockCheckAuthUseCase();
    cubit = AuthCubit(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
      logoutUseCase: mockLogoutUseCase,
      checkAuthUseCase: mockCheckAuthUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is AuthInitial', () {
    expect(cubit.state, const AuthInitial(formData: AuthFormData()));
  });

  const tUser = User(username: 'testuser', token: 'testtoken');

  group('checkAuth', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when user is logged in',
      build: () {
        when(
          () => mockCheckAuthUseCase(NoParams()),
        ).thenAnswer((_) async => tUser);
        return cubit;
      },
      act: (cubit) => cubit.checkAuth(),
      expect: () => [
        const AuthLoading(),
        const AuthAuthenticated(
          token: 'testtoken',
          username: 'testuser',
          formData: AuthFormData(),
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthUnauthenticated] when user is not logged in',
      build: () {
        when(
          () => mockCheckAuthUseCase(NoParams()),
        ).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.checkAuth(),
      expect: () => [
        const AuthLoading(),
        const AuthUnauthenticated(formData: AuthFormData()),
      ],
    );
  });
}
