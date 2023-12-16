// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HikingAdapter extends TypeAdapter<Hiking> {
  @override
  final int typeId = 1;

  @override
  Hiking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hiking(
      id: fields[0] as int,
      hikeName: fields[1] as String,
      startPoint: fields[2] as String,
      endPoint: fields[3] as String,
      startDate: fields[4] as DateTime,
      packingAvailble: fields[5] as bool,
      hikeLength: fields[6] as double,
      level: fields[7] as int,
      description: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hiking obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hikeName)
      ..writeByte(2)
      ..write(obj.startPoint)
      ..writeByte(3)
      ..write(obj.endPoint)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.packingAvailble)
      ..writeByte(6)
      ..write(obj.hikeLength)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HikingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
