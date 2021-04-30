// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enforcer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Enforcer _$EnforcerFromJson(Map<String, dynamic> json) {
  return Enforcer(
    json['cert_id'] as String,
    json['last_interaction'] as String,
    json['last_ip_address'] as String,
    json['allowed'] as bool,
  );
}

Map<String, dynamic> _$EnforcerToJson(Enforcer instance) => <String, dynamic>{
  'cert_id': instance.cert_id,
  'last_interaction': instance.last_interaction,
  'last_ip_address': instance.last_ip_address,
  'allowed': instance.allowed,
};
