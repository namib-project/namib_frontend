import 'package:json_annotation/json_annotation.dart';

part 'matches.g.dart';

@JsonSerializable()
class Matches{

  String address_mask, direction_initiated, dnsname;


  Matches(this.address_mask, this.direction_initiated, this.dnsname);

  factory Matches.fromJson(Map<String, dynamic> data) => _$MatchesFromJson(data);

  Map<String, dynamic> toJson() => _$MatchesToJson(this);
}