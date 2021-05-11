import 'package:json_annotation/json_annotation.dart';

part 'mudGuess.g.dart';

/// This class is a data construct for a MUD guess

@JsonSerializable(explicitToJson: true)
class MudGuess {
  String manufacturer_name, model_name, mud_url;

  MudGuess(this.manufacturer_name, this.model_name, this.mud_url);

  factory MudGuess.fromJson(Map<String, dynamic> data) =>
      _$MudGuessFromJson(data);

  Map<String, dynamic> toJson() => _$MudGuessToJson(this);
}
