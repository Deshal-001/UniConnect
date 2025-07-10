import 'package:json_annotation/json_annotation.dart';
import 'package:uniconnect_app/feature/event/domain/entity/event.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel extends Event {

  const EventModel({
    super.id,
    super.title,
    super.description,
    super.date,
    super.maxParticipants,
    super.currentAttendees,
    super.location,
    super.imgUrl,
    super.creatorId,
    super.universityId,
    super.universityName,
    super.restrictToUniversity,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}