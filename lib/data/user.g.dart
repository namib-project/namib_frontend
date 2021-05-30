// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['username'] as String,
    json['id'] as int,
    (json['roles'] as List)
        ?.map(
            (e) => e == null ? null : Roles.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'user_id': instance.id,
      'roles': instance.roles?.map((e) => e?.toJson())?.toList(),
    };
