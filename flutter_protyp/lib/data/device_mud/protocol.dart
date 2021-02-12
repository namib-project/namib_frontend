import 'package:json_annotation/json_annotation.dart';


// This class is a data construct for the used protocol

part 'protocol.g.dart';

@JsonSerializable()
class Protocol{

  String name;
  int num;

  Protocol(this.name, this.num);

  factory Protocol.fromJson(Map<String, dynamic> data) => _$ProtocolFromJson(data);

  Map<String, dynamic> toJson() => _$ProtocolToJson(this);
}