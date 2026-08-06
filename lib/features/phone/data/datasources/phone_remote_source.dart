import 'package:bloc_practice/features/phone/data/model/phone_model.dart';
import 'package:dart_either/dart_either.dart';

abstract class PhoneRemoteSource {
  Future<Either<Exception, List<PhoneModel>>> fetchPhoneList();
}
