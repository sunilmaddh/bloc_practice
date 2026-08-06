import 'package:bloc_practice/features/phone/data/model/phone_data_model.dart';
import 'package:bloc_practice/features/phone/domain/entities/phone_entity.dart';

class PhoneModel extends PhoneEntity {
  PhoneModel({super.id, super.name, PhoneDataModel? data}) : super(data: data);

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      data: json['data'] != null ? PhoneDataModel.fromJson(json['data']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'data': (data as PhoneDataModel?)?.toJson(),
    };
  }
}
