import 'package:json_annotation/json_annotation.dart';

// This class is a data construct for a user-model
part 'roles.g.dart';

@JsonSerializable(explicitToJson: true)
class Roles{

  int id;
  String name;

  Roles(this.id, this.name);

  factory Roles.fromJson(Map<String, dynamic> data) => _$RolesFromJson(data);

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}