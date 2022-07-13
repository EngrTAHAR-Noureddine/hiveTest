// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      title: fields[0] as String?,
      desc: fields[1] as String?,
      index: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {

    String y = obj.desc??"hello";
    print("y is: $y");

    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(y)
      ..writeByte(2)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
