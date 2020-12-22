// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      avtar: fields[3] as String,
      club: fields[7] as Club,
      dob: fields[5] as DateTime,
      email: fields[4] as String,
      position: fields[8] as String,
      memberShip: fields[6] as bool,
      token: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.avtar)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.memberShip)
      ..writeByte(7)
      ..write(obj.club)
      ..writeByte(8)
      ..write(obj.position)
      ..writeByte(9)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
