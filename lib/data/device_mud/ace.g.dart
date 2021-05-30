// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ACE _$ACEFromJson(Map<String, dynamic> json) {
  return ACE(
    json['name'] as String,
    json['action'] as String,
    json['matches'] == null
        ? null
        : Matches.fromJson(json['matches'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ACEToJson(ACE instance) => <String, dynamic>{
      'name': instance.name,
      'action': instance.action,
      'matches': instance.matches?.toJson(),
    };
