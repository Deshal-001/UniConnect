// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

University _$UniversityFromJson(Map<String, dynamic> json) => University(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      location: json['location'] as String?,
      imgUrl: json['imgUrl'] as String?,
    );

Map<String, dynamic> _$UniversityToJson(University instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'imgUrl': instance.imgUrl,
    };
