import 'package:bloc_practice/features/phone/domain/entities/phone_data_entity.dart';

class PhoneDataModel extends PhoneDataEntity {
  PhoneDataModel({
    super.capacity,
    super.capacityGb,
    super.caseSize,
    super.color,
    super.cpuModel,
    super.description,
    super.generation,
    super.hardDiskSize,
    super.price,
    super.screenSize,
    super.strapColour,
    super.year,
  });

  factory PhoneDataModel.fromJson(Map<String, dynamic> json) {
    return PhoneDataModel(
      color: json['color'] ?? json['Color'],
      capacity: json['capacity'] ?? json['Capacity'],
      capacityGb: json['capacity GB'] is int
          ? json['capacity GB']
          : int.tryParse(json['capacity GB']?.toString() ?? ''),
      price: _toDouble(json['price'] ?? json['Price']),
      generation: json['generation'] ?? json['Generation'],

      year: json['year'],

      cpuModel: json['CPU model'],

      hardDiskSize: json['Hard disk size'],

      strapColour: json['Strap Colour'],

      caseSize: json['Case Size'],

      description: json['Description'],

      screenSize: _toDouble(json['Screen size']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'capacity': capacity,
      'capacity GB': capacityGb,
      'price': price,
      'generation': generation,
      'year': year,
      'CPU model': cpuModel,
      'Hard disk size': hardDiskSize,
      'Strap Colour': strapColour,
      'Case Size': caseSize,
      'Description': description,
      'Screen size': screenSize,
    };
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;

    if (value is double) return value;

    if (value is int) return value.toDouble();

    return double.tryParse(value.toString());
  }
}
