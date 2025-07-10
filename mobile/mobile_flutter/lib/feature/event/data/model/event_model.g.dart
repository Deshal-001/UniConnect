// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      maxParticipants: (json['maxParticipants'] as num?)?.toInt(),
      currentAttendees: (json['currentAttendees'] as num?)?.toInt(),
      location: json['location'] as String?,
      imgUrl: json['imgUrl'] as String?,
      creatorId: (json['creatorId'] as num?)?.toInt(),
      universityId: (json['universityId'] as num?)?.toInt(),
      universityName: json['universityName'] as String?,
      restrictToUniversity: json['restrictToUniversity'] as bool?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date?.toIso8601String(),
      'maxParticipants': instance.maxParticipants,
      'currentAttendees': instance.currentAttendees,
      'location': instance.location,
      'imgUrl': instance.imgUrl,
      'creatorId': instance.creatorId,
      'universityId': instance.universityId,
      'universityName': instance.universityName,
      'restrictToUniversity': instance.restrictToUniversity,
    };
