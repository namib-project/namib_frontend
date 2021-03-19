// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
    json['roomname'] as String,
    json['roomcolor'] as String,
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'roomname': instance.roomname,
      'roomcolor': instance.roomcolor,
    };
