import 'package:clovertest/hive/home.dart';
import 'package:clovertest/hive/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive/models/User.dart';

void main() async{

  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TaskAdapter());

  // opening boxes or make futureBuilder to open this boxes
  await Hive.openBox('tasks1');
  await Hive.openBox('settings');
  await Hive.openBox('user3');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}
