import 'package:json_annotation/json_annotation.dart';

/// This class is a data construct for a source port element of an ace

part 'source_port.g.dart';

@JsonSerializable(explicitToJson: true)
class SourcePort {
  int single;
  List<int> range;

  SourcePort(this.single, this.range);

  factory SourcePort.fromJson(Map<String, dynamic> data) =>
      _$SourcePortFromJson(data);

  Map<String, dynamic> toJson() => _$SourcePortToJson(this);
}
