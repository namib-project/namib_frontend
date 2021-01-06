
import 'package:json_annotation/json_annotation.dart';



part 'mudservice.g.dart';

@JsonSerializable()
class MUDService{
    String name, product, method;


    MUDService({this.name, this.product, this.method});

  factory MUDService.fromJson(Map<String, dynamic> data) => _$MUDServiceFromJson(data);

  Map<String, dynamic> toJson() => _$MUDServiceToJson(this);
}