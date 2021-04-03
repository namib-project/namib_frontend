// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['username'] as String,
    json['userIDs'] as int,
    json['roles'] as List,
    json['permissionsList'] as List,
    json['user'] as bool,
    json['admin'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'userIDs': instance.userIDs,
      'roles': instance.roles,
      'permissionsList': instance.permissionsList,
      'user': instance.user,
      'admin': instance.admin,
    };
