import 'package:hive/hive.dart';

class User extends HiveObject{
  String? name;
  String familyname;

  User({ this.name,required this.familyname});

}

// Can be generated automatically
class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId =218;

  @override
  User read(BinaryReader reader) {

    return User(name: reader.read(),familyname: reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {

    final v = obj.name == null ?"test2":obj.name;

    print(v);
    writer
      ..write(v)
      ..write(obj.familyname);
  }
}