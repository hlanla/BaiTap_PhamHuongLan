import 'package:hive/hive.dart';
import 'package:jogging_app/constant/hive_db.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hiking.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveBoxId.hiking)
class Hiking {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'hikeName')
  final String hikeName;

  @JsonKey(name: 'startPoint')
  @HiveField(2)
  final String startPoint;

  @JsonKey(name: 'endPoint')
  @HiveField(3)
  final String endPoint;

  @JsonKey(name: 'startDate')
  @HiveField(4)
  final DateTime startDate;

  @JsonKey(name: 'packingAvailble')
  @HiveField(5)
  final bool packingAvailble;

  @JsonKey(name: 'hikeLength')
  @HiveField(6)
  final double hikeLength;

  @JsonKey(name: 'level')
  @HiveField(7)
  final int level;

  @JsonKey(name: 'description')
  @HiveField(8)
  final String? description;

  Hiking({
    this.id = 0,
    required this.hikeName,
    required this.startPoint,
    required this.endPoint,
    required this.startDate,
    required this.packingAvailble,
    required this.hikeLength,
    required this.level,
    this.description,
  });

  Hiking copyWith({
    int? id,
    String? hikeName,
    String? startPoint,
    String? endPoint,
    DateTime? startDate,
    bool? packingAvailble,
    double? hikeLength,
    int? level,
    String? description,
  }) {
    return Hiking(
      id: id ?? this.id,
      hikeName: hikeName ?? this.hikeName,
      startPoint: startPoint ?? this.startPoint,
      endPoint: endPoint ?? this.endPoint,
      startDate: startDate ?? this.startDate,
      packingAvailble: packingAvailble ?? this.packingAvailble,
      hikeLength: hikeLength ?? this.hikeLength,
      level: level ?? this.level,
      description: description ?? this.description,
    );
  }
}
