// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matches _$MatchesFromJson(Map<String, dynamic> json) {
  return Matches(
    json['address_mask'] as String,
    json['direction_initiated'] as String,
    json['dnsname'] as String,
    json['protocol'] == null
        ? null
        : Protocol.fromJson(json['protocol'] as Map<String, dynamic>),
    json['destination_port'] == null
        ? null
        : DestinationPort.fromJson(
            json['destination_port'] as Map<String, dynamic>),
    json['source_port'] == null
        ? null
        : SourcePort.fromJson(json['source_port'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MatchesToJson(Matches instance) => <String, dynamic>{
      'address_mask': instance.address_mask,
      'direction_initiated': instance.direction_initiated,
      'dnsname': instance.dnsname,
      'protocol': instance.protocol,
      'destination_port': instance.destination_port,
      'source_port': instance.source_port,
    };
