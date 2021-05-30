// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_port.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourcePort _$SourcePortFromJson(Map<String, dynamic> json) {
  return SourcePort(
    json['single'] as int,
    (json['range'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$SourcePortToJson(SourcePort instance) =>
    <String, dynamic>{
      'single': instance.single,
      'range': instance.range,
    };
