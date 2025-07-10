import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final int? maxParticipants;
  final int? currentAttendees;
  final String? location;
  final String? imgUrl;
  final int? creatorId;
  final int? universityId;
  final String? universityName;
  final bool? restrictToUniversity;

  const Event({
    this.id,
    this.title,
    this.description,
    this.date,
    this.maxParticipants,
    this.currentAttendees,
    this.location,
    this.imgUrl,
    this.creatorId,
    this.universityId,
    this.universityName,
    this.restrictToUniversity,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        maxParticipants,
        currentAttendees,
        location,
        imgUrl,
        creatorId,
        universityId,
        universityName,
        restrictToUniversity,
      ];

  @override
  bool get stringify => true;
}
