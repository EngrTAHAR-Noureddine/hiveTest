import 'package:clovertest/hive/controller/Controller.dart';
import 'package:clovertest/hive/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatelessWidget {

  HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          HiveController hiveController = HiveController();
          hiveController.addTask();
        },
        child: const Icon(Icons.add , color: Colors.white,),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                color: Colors.white54,
                child: StreamBuilder(
                  stream: Hive.box('tasks').watch(),
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
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box('tasks').listenable(),
                        builder: (context, box, widget) {
                          if(box != null){

                            Box myBox = box as Box;

                            return ListView.builder(
                              itemCount: myBox.length,
                              itemBuilder: (context, index){

                                return ListTile(
                                  title: Text(myBox.getAt(index).title),
                                  subtitle: Text(myBox.getAt(index).desc),
                                  onTap: (){},
                                );
                              },

                            );
                          }else{
                            return const CircularProgressIndicator();
                          }



                        },
                      ),

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