
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'university.g.dart';

@JsonSerializable()
class University extends Equatable {
  final String id;
  final String name;
  final String location;

  const University({
    required this.id,
    required this.name,
    required this.location,
  });


  factory University.fromJson(Map<String, dynamic> json) =>
      _$UniversityFromJson(json);
  Map<String, dynamic> toJson() => _$UniversityToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        location,
      ];

  @override
  bool get stringify => true;
  @override
  String toString() {
    return 'UniversityModel { id: $id, name: $name, logoUrl: $location }';
  }
}