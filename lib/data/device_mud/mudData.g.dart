// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mudData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUDData _$MUDDataFromJson(Map<String, dynamic> json) {
  return MUDData(
    (json['acllist'] as List)
        ?.map((e) =>
            e == null ? null : ACLElement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['acl_override'] as List)
        ?.map((e) =>
            e == null ? null : ACLElement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['documentation'] as String,
    json['last_update'] as String,
    json['masa_url'] as String,
    json['mfg_name'] as String,
    json['model_name'] as String,
    json['systeminfo'] as String,
    json['url'] as String,
    json['expiration'] as String,
  );
}

Map<String, dynamic> _$MUDDataToJson(MUDData instance) => <String, dynamic>{
      'acllist': instance.acllist?.map((e) => e?.toJson())?.toList(),
      'acl_override': instance.acl_override?.map((e) => e?.toJson())?.toList(),
      'documentation': instance.documentation,
      'last_update': instance.last_update,
      'masa_url': instance.masa_url,
      'mfg_name': instance.mfg_name,
      'model_name': instance.model_name,
      'systeminfo': instance.systeminfo,
      'url': instance.url,
      'expiration': instance.expiration,
    };
