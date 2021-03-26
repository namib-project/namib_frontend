// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mudGuess.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MudGuess _$MudGuessFromJson(Map<String, dynamic> json) {
  return MudGuess(
    json['manufacturer_name'] as String,
    json['model_name'] as String,
    json['mud_url'] as String,
  );
}

Map<String, dynamic> _$MudGuessToJson(MudGuess instance) => <String, dynamic>{
      'manufacturer_name': instance.manufacturer_name,
      'model_name': instance.model_name,
      'mud_url': instance.mud_url,
    };
