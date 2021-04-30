import 'package:json_annotation/json_annotation.dart';

// This class is a data construct for a enforcer
part 'enforcer.g.dart';

@JsonSerializable(explicitToJson: true)
class Enforcer{

  String cert_id, last_interaction, last_ip_address;
  bool allowed;


  Enforcer(
      this.cert_id, this.last_interaction, this.last_ip_address, this.allowed);

  factory Enforcer.fromJson(Map<String, dynamic> data) => _$EnforcerFromJson(data);

  Map<String, dynamic> toJson() => _$EnforcerToJson(this);
}