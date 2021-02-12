// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_port.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationPort _$DestinationPortFromJson(Map<String, dynamic> json) {
  return DestinationPort(
    json['single'] as int,
    (json['range'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$DestinationPortToJson(DestinationPort instance) =>
    <String, dynamic>{
      'single': instance.single,
      'range': instance.range,
    };
