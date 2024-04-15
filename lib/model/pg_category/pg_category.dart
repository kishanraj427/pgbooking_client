// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';
part 'pg_category.g.dart';

@JsonSerializable()
class PG_category {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "gender")
  String? gender;

  PG_category({
    this.id,
    this.gender,
  });

  factory PG_category.fromJson(Map<String, dynamic> json) =>
      _$PG_categoryFromJson(json);
  Map<String, dynamic> toJson() => _$PG_categoryToJson(this);
}
