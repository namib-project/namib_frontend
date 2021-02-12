import 'package:flutter_protyp/data/device_mud/destination_port.dart';
import 'package:flutter_protyp/data/device_mud/protocol.dart';
import 'package:flutter_protyp/data/device_mud/source_port.dart';
import 'package:json_annotation/json_annotation.dart';


// This class is a data construct for a DNS-entry

part 'matches.g.dart';

@JsonSerializable()
class Matches{

  String address_mask, direction_initiated, dnsname;
  Protocol protocol;
  DestinationPort destination_port;
  SourcePort source_port;


  Matches(this.address_mask, this.direction_initiated, this.dnsname,
      this.protocol, this.destination_port, this.source_port);

  factory Matches.fromJson(Map<String, dynamic> data) => _$MatchesFromJson(data);

  Map<String, dynamic> toJson() => _$MatchesToJson(this);
}