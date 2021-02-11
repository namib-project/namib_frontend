// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';
// This class is generated, it converts an user-model to map and other direction

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['username'] as String,
    json['admin'] as bool,
    json['user'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'admin': instance.admin,
      'user': instance.user,
    };
