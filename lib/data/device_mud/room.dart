import 'package:json_annotation/json_annotation.dart';

/// This class is a data construct for a room

part 'room.g.dart';

@JsonSerializable(explicitToJson: true)
class Room {
  int id;
  String name, color;

  Room(this.id, this.name, this.color);

  Room.roomConstructor(int id, String name, String color) {
    this.id = id;
    this.name = name;
    this.color = color;
  }

  factory Room.fromJson(Map<String, dynamic> data) => _$RoomFromJson(data);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
