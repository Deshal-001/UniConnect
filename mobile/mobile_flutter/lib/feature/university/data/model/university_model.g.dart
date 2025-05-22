// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityModel _$UniversityModelFromJson(Map<String, dynamic> json) =>
    UniversityModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      location: json['location'] as String?,
      imgUrl: json['imgUrl'] as String?,
    );

Map<String, dynamic> _$UniversityModelToJson(UniversityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'imgUrl': instance.imgUrl,
    };
