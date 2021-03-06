import 'package:flutter_protyp/data/roles.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// This class is a data construct for a user

@JsonSerializable(explicitToJson: true)
class User {
  String username;
  int id;
  List<Roles> roles;

  User(this.username, this.id, this.roles);

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
