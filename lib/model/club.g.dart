// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClubAdapter extends TypeAdapter<Club> {
  @override
  final int typeId = 2;

  @override
  Club read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Club(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[3] as String,
      poster: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Club obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.poster)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
