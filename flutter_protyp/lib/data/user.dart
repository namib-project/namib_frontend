
import 'package:json_annotation/json_annotation.dart';

// This class is a data construct for a user-model
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User{
  String username;
  bool admin;


  User(this.username, this.admin);

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}