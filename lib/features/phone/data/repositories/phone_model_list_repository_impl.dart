import 'package:bloc_practice/features/phone/data/datasources/phone_remote_source.dart';
import 'package:bloc_practice/features/phone/domain/entities/phone_entity.dart';
import 'package:bloc_practice/features/phone/domain/repositories/phone_model_list_repositories.dart';
import 'package:dart_either/dart_either.dart';

class PhoneModelListRepositoryImpl extends PhoneModelListRepositories {
  final PhoneRemoteSource phoneRemoteSource;
  PhoneModelListRepositoryImpl({required this.phoneRemoteSource});
  @override
  Future<Either<Exception, List<PhoneEntity>>> fetchPhoneList() {
    return phoneRemoteSource.fetchPhoneList();
  }
}
