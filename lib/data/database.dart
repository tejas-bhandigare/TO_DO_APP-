import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{


List toDoList =[];


  //referance our box

  final _myBox = Hive.box('mybox');

  void createInitialData(){
    toDoList =[
      ["make tutorial",false],
      ["do exercise",false],

    ];
  }

  void loadData(){

    toDoList = _myBox.get("TODOLIST");

  }

  //update data

void updateDataBase(){
  _myBox.put("TODOLIST",toDoList);

}
}