import 'package:json_annotation/json_annotation.dart';

// This class is a data construct for a rooms

part 'room.g.dart';

@JsonSerializable(explicitToJson: true)
class Room {
  int id;
  String name, color;

  Room(this.id, this.name, this.color);

  factory Room.fromJson(Map<String, dynamic> data) => _$RoomFromJson(data);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
