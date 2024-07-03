import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {

  final String taskName;
  final bool taskComplated;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;


    TodoTile({super.key,
   required this.taskName,
     required this.taskComplated,
     required this.onChanged,
      required this.deleteFunction,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0,right: 25,top: 25),
       child: Slidable(
         endActionPane:ActionPane(
          motion: StretchMotion(),
           children: [
             SlidableAction(onPressed: deleteFunction,
             icon: Icons.delete,
               backgroundColor: Colors.redAccent,
               borderRadius: BorderRadius.circular(12),
             )
           ],
         ),

        child: Container(
         padding: EdgeInsets.all(24),
         child: Row(
           children :[
             //checkbox
             Checkbox(
                 value: taskComplated,
                 onChanged: onChanged,
                 activeColor: Colors.black

             ),
             //task name
              Text(
                  taskName,
                style: TextStyle(
                  decoration: taskComplated ? TextDecoration.lineThrough : TextDecoration.none,
                ),

              ),
           ] ,
         ),


         decoration: BoxDecoration(
           color: Colors.yellow,
           borderRadius: BorderRadius.circular(12),
         ),
       )
       )
    );
  }
}
