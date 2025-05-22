
import 'package:json_annotation/json_annotation.dart';
import 'package:uniconnect_app/feature/university/domain/entity/university.dart';

part 'university_model.g.dart';

@JsonSerializable()
class UniversityModel extends University {

  const UniversityModel({
     super.id,
     super.name,
     super.location,
    super.imgUrl,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UniversityModelToJson(this);
}