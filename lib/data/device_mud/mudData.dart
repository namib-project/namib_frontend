import 'package:flutter_protyp/data/device_mud/aclElement.dart';
import 'package:json_annotation/json_annotation.dart';

/// This class is a data construct for a MUD-Profile

part 'mudData.g.dart';

@JsonSerializable(explicitToJson: true)
class MUDData {
  List<ACLElement> acllist;
  List<ACLElement> acl_override;
  String documentation,
      last_update,
      masa_url,
      mfg_name,
      model_name,
      systeminfo,
      url,
      expiration;

  MUDData(
      this.acllist,
      this.acl_override,
      this.documentation,
      this.last_update,
      this.masa_url,
      this.mfg_name,
      this.model_name,
      this.systeminfo,
      this.url,
      this.expiration);

  factory MUDData.fromJson(Map<String, dynamic> data) =>
      _$MUDDataFromJson(data);

  Map<String, dynamic> toJson() => _$MUDDataToJson(this);
}
