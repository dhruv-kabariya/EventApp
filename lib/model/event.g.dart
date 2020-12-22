// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 3;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      id: fields[0] as int,
      name: fields[1] as String,
      poster: fields[2] as String,
      club: fields[8] as Club,
      date: fields[3] as DateTime,
      decsription: fields[4] as String,
      link: fields[7] as String,
      spokePerson: fields[5] as String,
      venue: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.poster)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.decsription)
      ..writeByte(5)
      ..write(obj.spokePerson)
      ..writeByte(6)
      ..write(obj.venue)
      ..writeByte(7)
      ..write(obj.link)
      ..writeByte(8)
      ..write(obj.club);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
