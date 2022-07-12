import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
// Annotate all fields which should be stored with HiveField
//create Task.g.dart as empty file .dart and run this command when you add the dependecies build runner and hive generator
// > flutter packages pub run build_runner build
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? desc;

  @HiveField(2)
  int? index;

  Task({this.title,this.desc,this.index});
}