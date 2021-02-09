// GENERATED CODE - DO NOT MODIFY BY HAND
// This class is generated, it converts an access-control-list to map and other direction
part of 'aclElement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ACLElement _$ACLElementFromJson(Map<String, dynamic> json) {
  return ACLElement(
    json['acl_type'] as String,
    json['name'] as String,
    json['packet_direction'] as String,
    (json['ace'] as List)
        ?.map((e) => e == null ? null : ACE.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ACLElementToJson(ACLElement instance) =>
    <String, dynamic>{
      'acl_type': instance.acl_type,
      'name': instance.name,
      'packet_direction': instance.packet_direction,
      'ace': instance.ace?.map((e) => e?.toJson())?.toList(),
    };
