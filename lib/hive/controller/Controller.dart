import 'package:clovertest/hive/models/Task.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/User.dart';

class HiveController{

  openningHiveBox()async{

    Box boxSettings = await Hive.openBox('settings');

     boxSettings.put('darkMode', false);

     var darkmode = boxSettings.get('darkMode');

     if (kDebugMode) {
       print('is in dark mode : $darkmode');
     }

  }

  addTask(String box,Task task,Function f)async{
    Box boxTasks = Hive.box(box);

    Box boxSettings = Hive.box('settings');

    bool? darkmode = boxSettings.get('darkMode');
    if(darkmode != null){
      darkmode = !darkmode;
    }else{
      darkmode= false;
    }

    boxSettings.put('darkMode', darkmode);

    int l = boxTasks.length;
    if(l.isNaN) l = 0;

      // add task

   task.index = l+1;

    boxTasks.add(task);

    task.save();

    f();

    /*
    // update a task
    Task t1 = boxTasks.getAt(0);

    t1.title  = "${t1.title} -";
    t1.save();


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


  addUser(String box, User user ,Function f)async{
    Box boxUsers = Hive.box(box);

    boxUsers.add(user);

    user.save();
    f();
  }

  onClearBox(String box,Function f)async{
    Box boxUsers = Hive.box(box);
    boxUsers.clear();
    f();
  }





}