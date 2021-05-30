// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Protocol _$ProtocolFromJson(Map<String, dynamic> json) {
  return Protocol(
    json['name'] as String,
    json['num'] as int,
  );
}

Map<String, dynamic> _$ProtocolToJson(Protocol instance) => <String, dynamic>{
      'name': instance.name,
      'num': instance.num,
    };
