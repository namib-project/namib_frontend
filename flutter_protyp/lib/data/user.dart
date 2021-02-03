
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User{
  String username;
  bool admin, guest;


  User(this.username, this.admin, this.guest);

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}