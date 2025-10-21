import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:slot_booking_app/features/auth/data/data_provider/auth_data_provider.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/models/token_model.dart';

@GenerateMocks([AuthDataProvider])
import 'auth_repository_test.mocks.dart';

void main() {
  late AuthRepository authRepository;
  late MockAuthDataProvider mockAuthDataProvider;

  setUp(() {
    mockAuthDataProvider = MockAuthDataProvider();
    authRepository = AuthRepository(authDataProvider: mockAuthDataProvider);
  });

  group('AuthRepository', () {
    group('login', () {
      test('should return a TokenModel when login is successful', () async {
        const email = 'test@gmail.com';
        const password = 'Abcd@1234';
        const expectedToken = 'test_token';

        when(
          mockAuthDataProvider.login(email: email, password: password),
        ).thenAnswer((_) async => {'token': expectedToken});

        final result = await authRepository.login(
          email: email,
          password: password,
        );

        expect(result, isA<TokenModel>());
        expect(result.token, expectedToken);
      });

      test('should throw Exception when login fails', () async {
        const email = 'test@gmail.com';
        const password = 'wrong_password';

        when(
          mockAuthDataProvider.login(email: email, password: password),
        ).thenThrow(Exception('Invalid credentials'));

        expect(
          () => authRepository.login(email: email, password: password),
          throwsA(isA<Exception>()),
        );
      });

      test('should throw Exception when response is null', () async {
        const email = 'test@gmail.com';
        const password = 'Abcd@1234';

        when(
          mockAuthDataProvider.login(email: email, password: password),
        ).thenAnswer((_) async => <String, dynamic>{});

        expect(
          () => authRepository.login(email: email, password: password),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('register', () {
      test(
        'should return a TokenModel when registration is successful',
        () async {
          const name = 'Test User';
          const email = 'test@gmail.com';
          const password = 'Abcd@1234';
          const expectedToken = 'test_token';

          when(
            mockAuthDataProvider.register(
              name: name,
              email: email,
              password: password,
            ),
          ).thenAnswer((_) async => {'token': expectedToken});

          final result = await authRepository.register(
            name: name,
            email: email,
            password: password,
          );

          expect(result, isA<TokenModel>());
          expect(result.token, expectedToken);
        },
      );

      test('should throw Exception when registration fails', () async {
        const name = 'Test User';
        const email = 'test@gmail.com';
        const password = 'weak';

        when(
          mockAuthDataProvider.register(
            name: name,
            email: email,
            password: password,
          ),
        ).thenThrow(Exception('Registration failed'));

        expect(
          () => authRepository.register(
            name: name,
            email: email,
            password: password,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
