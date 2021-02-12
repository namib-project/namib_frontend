import 'package:flutter_protyp/data/device_mud/ace.dart';
import 'package:flutter_protyp/data/device_mud/matches.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aclElement.g.dart';

// This class is a data construct for an access-control-list

@JsonSerializable(explicitToJson: true)
class ACLElement{
  String acl_type, name, packet_direction;
  List<ACE> ace;

  ACLElement(this.acl_type, this.name, this.packet_direction, this.ace);

  factory ACLElement.fromJson(Map<String, dynamic> data) => _$ACLElementFromJson(data);

  Map<String, dynamic> toJson() => _$ACLElementToJson(this);
}