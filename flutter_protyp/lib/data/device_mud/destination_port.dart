import 'package:json_annotation/json_annotation.dart';


// This class is a data construct for a destination port

part 'destination_port.g.dart';

@JsonSerializable(explicitToJson: true)
class DestinationPort{

  int single;
  List<int> range;

  DestinationPort(this.single, this.range);

  factory DestinationPort.fromJson(Map<String, dynamic> data) => _$DestinationPortFromJson(data);

  Map<String, dynamic> toJson() => _$DestinationPortToJson(this);
}