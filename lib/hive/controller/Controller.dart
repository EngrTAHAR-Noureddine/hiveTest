import 'package:clovertest/hive/models/Task.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveController{

  openningHiveBox()async{

    Box boxSettings = await Hive.openBox('settings');

     boxSettings.put('darkMode', false);

     var darkmode = boxSettings.get('darkMode');

     if (kDebugMode) {
       print('is in dark mode : $darkmode');
     }

  }

  addTask()async{
    Box boxTasks = await Hive.openBox('tasks');

    Box boxSettings = await Hive.openBox('settings');

    bool? darkmode = boxSettings.get('darkMode');
    if(darkmode != null){
      darkmode = !darkmode;
    }else{
      darkmode= false;
    }

    boxSettings.put('darkMode', darkmode);

    int l = boxTasks.length;
    if(l.isNaN) l = 0;
/*
      // add task

    Task task = Task(title: "title ${l+1}", desc: "task registered",index: l+1);

    boxTasks.add(task);

    task.save();
*/


    // update a task
    Task t1 = boxTasks.getAt(0);

    t1.title  = "${t1.title} -";
    t1.save();

    /*
    //delete item
    if (kDebugMode) {
      print('length is $l');
     // print('title : ${t1.title}');
    }
    boxTasks.deleteAt(l-1);
    if (kDebugMode) {
      print('deleted ');
    }
    */

  }







}