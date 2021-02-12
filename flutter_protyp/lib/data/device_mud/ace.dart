import 'package:flutter_protyp/data/device_mud/matches.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ace.g.dart';

// This class is a data construct for an access-control-entry

@JsonSerializable(explicitToJson: true)
class ACE{
  String name, action;
  Matches matches;

  ACE(this.name, this.matches);

  factory ACE.fromJson(Map<String, dynamic> data) => _$ACEFromJson(data);

  Map<String, dynamic> toJson() => _$ACEToJson(this);
}