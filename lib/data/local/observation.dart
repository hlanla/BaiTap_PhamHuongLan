import 'dart:io';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogging_app/constant/hive_db.dart';
import 'package:json_annotation/json_annotation.dart';

part 'observation.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveBoxId.observation)
class Observation {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(5)
  @JsonKey(name: 'joggingId')
  final int joggingId;

  @HiveField(1)
  @JsonKey(name: 'observationName')
  final String observationName;

  @JsonKey(name: 'observationTime')
  @HiveField(2)
  final DateTime observationTime;

  @JsonKey(name: 'description')
  @HiveField(3)
  final String? description;

  @JsonKey(name: 'images')
  @HiveField(4)
  final List<String> images;

  Observation({
    this.id = -1,
    this.observationName = "",
    this.description,
    DateTime? observationTime,
    this.images = const [],
    this.joggingId = -1,
  }) : observationTime = observationTime ?? DateTime.now();

  Observation copyWith({
    int? id,
    int? joggingId,
    String? observationName,
    DateTime? observationTime,
    String? description,
    List<String>? images,
  }) {
    return Observation(
      id: id ?? this.id,
      joggingId: joggingId ?? this.joggingId,
      observationName: observationName ?? this.observationName,
      observationTime: observationTime ?? this.observationTime,
      description: description ?? this.description,
      images: images ?? this.images,
    );
  }
}
