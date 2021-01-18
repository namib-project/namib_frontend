import 'package:flutter_protyp/data/aclElement.dart';
import 'package:flutter_protyp/data/matches.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ace.g.dart';

@JsonSerializable(explicitToJson: true)
class ACE{
  String name, action;
  Matches matches;

  ACE(this.name, this.matches);

  factory ACE.fromJson(Map<String, dynamic> data) => _$ACEFromJson(data);

  Map<String, dynamic> toJson() => _$ACEToJson(this);
}