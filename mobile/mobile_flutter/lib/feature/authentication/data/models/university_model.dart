
import 'package:json_annotation/json_annotation.dart';
import 'package:uniconnect_app/feature/authentication/domain/entities/university.dart';

part 'university_model.g.dart';

@JsonSerializable()
class UniversityModel extends University {

  const UniversityModel({
    required super.id,
    required super.name,
    required super.location,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UniversityModelToJson(this);
}