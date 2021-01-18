import 'package:flutter_protyp/data/ace.dart';
import 'package:flutter_protyp/data/matches.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aclElement.g.dart';

@JsonSerializable(explicitToJson: true)
class ACLElement{
  String acl_type, name, packet_direction;
  List<ACE> ace;

  ACLElement(this.acl_type, this.name, this.packet_direction, this.ace);

  factory ACLElement.fromJson(Map<String, dynamic> data) => _$ACLElementFromJson(data);

  Map<String, dynamic> toJson() => _$ACLElementToJson(this);
}