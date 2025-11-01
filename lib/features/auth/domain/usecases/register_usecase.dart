import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class RegisterUseCase {
  final AuthRepository repo;
  RegisterUseCase(this.repo);

  Future<Either<Failure, TokenEntity>> call(
    String name,
    String email,
    String password,
    bool isDoctor,
    String? hospital,
    String? designation,
  ) => repo.register(name, email, password, isDoctor, hospital, designation);
}
