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
  );
}

Map<String, dynamic> _$MatchesToJson(Matches instance) => <String, dynamic>{
      'address_mask': instance.address_mask,
      'direction_initiated': instance.direction_initiated,
      'dnsname': instance.dnsname,
    };
