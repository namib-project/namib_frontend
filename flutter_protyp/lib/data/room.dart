import 'package:json_annotation/json_annotation.dart';

// This class is a data construct for a user-model
part 'room.g.dart';

@JsonSerializable(explicitToJson: true)
class Room {
  String roomname;
  String roomcolor;

  Room(this.roomname, this.roomcolor);

  factory Room.fromJson(Map<String, dynamic> data) => _$RoomFromJson(data);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
