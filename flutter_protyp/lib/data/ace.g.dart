// GENERATED CODE - DO NOT MODIFY BY HAND
// This class is generated, it converts an access-control-entry to map and other direction
part of 'ace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ACE _$ACEFromJson(Map<String, dynamic> json) {
  return ACE(
    json['name'] as String,
    json['matches'] == null
        ? null
        : Matches.fromJson(json['matches'] as Map<String, dynamic>),
  )..action = json['action'] as String;
}

Map<String, dynamic> _$ACEToJson(ACE instance) => <String, dynamic>{
      'name': instance.name,
      'action': instance.action,
      'matches': instance.matches?.toJson(),
    };
