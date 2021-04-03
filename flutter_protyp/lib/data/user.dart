
import 'package:json_annotation/json_annotation.dart';

// This class is a data construct for a user-model
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User{
  String username;
  int userIDs;
  List<dynamic> roles;
  List<dynamic> permissionsList;
  bool user;
  bool admin;


  User(this.username, this.userIDs, this.roles, this.permissionsList, this.user, this.admin);

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}