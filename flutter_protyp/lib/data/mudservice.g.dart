// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mudservice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUDService _$MUDServiceFromJson(Map<String, dynamic> json) {
  return MUDService(
    name: json['name'] as String,
    product: json['product'] as String,
    method: json['method'] as String,
  );
}

Map<String, dynamic> _$MUDServiceToJson(MUDService instance) =>
    <String, dynamic>{
      'name': instance.name,
      'product': instance.product,
      'method': instance.method,
    };
