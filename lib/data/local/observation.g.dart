// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObservationAdapter extends TypeAdapter<Observation> {
  @override
  final int typeId = 2;

  @override
  Observation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Observation(
      id: fields[0] as int,
      observationName: fields[1] as String,
      description: fields[3] as String?,
      observationTime: fields[2] as DateTime?,
      images: (fields[4] as List).cast<String>(),
      joggingId: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Observation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.joggingId)
      ..writeByte(1)
      ..write(obj.observationName)
      ..writeByte(2)
      ..write(obj.observationTime)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObservationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
