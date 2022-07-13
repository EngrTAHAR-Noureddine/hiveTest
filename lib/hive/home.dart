import 'package:clovertest/hive/controller/Controller.dart';
import 'package:clovertest/hive/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/User.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();

}

class _HomePage extends State {


  final TextEditingController _oneController = TextEditingController();
  final TextEditingController _twoController = TextEditingController();
  String boxStr = "user3";

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          HiveController hiveController = HiveController();

/*

          Task task = Task(title: _oneController.text , desc: _twoController.text);
          if(_twoController.text.isEmpty) task.desc = null;

          hiveController.addTask(boxStr,task ,() {

            setState(() {

            });
          });

*/


          User user = User(name: _oneController.text , familyname: _twoController.text);
          if(_oneController.text.isEmpty) user.name = null;

          hiveController.addUser(boxStr,user ,() {

            setState(() {

            });
          });

          _oneController.clear();
          _twoController.clear();
        },
        child: const Icon(Icons.add , color: Colors.white,),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [

            Expanded(
              child: TextField(
                controller: _oneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            const SizedBox(width: 10, height: 10,),
            Expanded(
              child: TextField(
                controller: _twoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Desc',
                ),
              ),
            ),

          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
              child: Container(
                color: Colors.white54,
                child: StreamBuilder(
                  stream: Hive.box('tasks1').watch(),
                  builder: (context, snapshot){
                    if(snapshot.hasData && snapshot.data!=null){
                      // if you use BoxSettings -> the value of boxEvent is the same of darkMode (true or false)
                      // if you use BoxTask -> the vaue of BoxValue is last item added to the box ( last event) or update item
                      // like this :
                      /*
                      BoxEvent event = snapshot.data as BoxEvent;
                      print("event : ${(event.value as Task).title}");
                      * */

                      BoxEvent event = snapshot.data as BoxEvent;
                      // if you use BoxTask -> the vaue of BoxValue is null when delete item and deleted is true
                      print("event : ${event.value} - is deleted ${event.deleted}");

                    }

                    return  const Center(
                      child: Text('test Box.watch and BoxEvent'),
                    );
                  },
                ),
              )
          ),
          Expanded(
            flex: 4,
            child: ValueListenableBuilder(
              valueListenable: Hive.box('settings').listenable(),

              builder: (context,Box box, widget) {

                  bool darkmode = box.get('darkMode') as bool;

                  return  Container(

                    color: (darkmode)? Colors.white38 : Colors.greenAccent,

                    child:  Center(
                      child: ListView.builder(
                        itemCount: Hive.box(boxStr).length,
                        itemBuilder: (context, index){
                          var boxUsers= Hive.box(boxStr);
                          return ListTile(
                            title:  /* Text(boxUsers.getAt(index).title.toString()),*/ Text(boxUsers.getAt(index).name.toString()),
                            subtitle: /*Text(boxUsers.getAt(index).desc.toString()), */ Text(boxUsers.getAt(index).familyname.toString()),
                            onTap: (){
                              HiveController hiveController = HiveController();
                              hiveController.onClearBox(boxStr,() {

                                setState(() {

                                });
                              });
                            },
                          );
                        },

                      )

                    ),
                  );


              },
            ),
          ),
        ],
      ),



    );

  }
}