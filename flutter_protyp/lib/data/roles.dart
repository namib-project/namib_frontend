import 'package:json_annotation/json_annotation.dart';

part 'roles.g.dart';

/// This class is a data construct for a role

@JsonSerializable(explicitToJson: true)
class Roles {
  int id;
  String name;

  Roles(this.id, this.name);

  factory Roles.fromJson(Map<String, dynamic> data) => _$RolesFromJson(data);

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}
