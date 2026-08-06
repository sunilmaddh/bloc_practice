import 'package:bloc_practice/features/phone/domain/entities/phone_data_entity.dart';

class PhoneEntity {
  final String? id;
  final String? name;
  final PhoneDataEntity? data;

  const PhoneEntity({this.id, this.name, this.data});
}
