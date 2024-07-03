import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list_app/data/database.dart';
import 'package:to_do_list_app/util/dialog_box.dart';

import 'package:to_do_list_app/util/todo_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState  extends State<HomePage> {

//hive box
final _myBox = Hive.box('mybox');

ToDoDataBase db = ToDoDataBase();

@override
void initState(){
  if(_myBox.get("TODOLIST") == null ){
    db.createInitialData();

  } else{
    db.loadData();
  }
  super.initState();

}
  final _controller = TextEditingController();





  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

    });
    db.updateDataBase();


  }
void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();

    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  //save the new task


  //create new task
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context){
      return DialogBox(

        controller: _controller,
        onSave: saveNewTask,
        onCancle: () => Navigator.of(context).pop(),
      );
    },
    );
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar:
      AppBar(
backgroundColor: Colors.yellow,
        title: Text("TO DO LIST"),
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,

      ),
      body: ListView.builder(
itemCount: db.toDoList.length,
        itemBuilder: (context,index) {
        return TodoTile(
            taskName: db.toDoList[index][0],
            taskComplated: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value ,index),
            deleteFunction: (context) => deleteTask(index),
        );
        },
      ),
    );
  }
}


