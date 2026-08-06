import 'package:bloc_practice/features/phone/domain/entities/phone_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class PhoneModelListRepositories {
  Future<Either<Exception, List<PhoneEntity>>> fetchPhoneList();
}
