import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? delete;
   ExpenseTile({super.key, 
   required this.name, 
   required this.amount, 
   required this.dateTime,
   required this.delete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [SlidableAction(
        onPressed: delete ,
        icon: Icons.delete,
        backgroundColor: Colors.red.shade300,
        borderRadius: BorderRadius.circular(10),
      
    
        )]),
      child: ListTile(title: Text(name,style:const  TextStyle(color: Colors.black,
      fontSize: 20,fontWeight: FontWeight.w400),),
           subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}',
           style:const  TextStyle(color: Color.fromARGB(255, 86, 83, 83),
           fontSize: 15,fontWeight: FontWeight.w400)),
           trailing: Text( '₹$amount',style:const  TextStyle(
            color: Color.fromARGB(255, 5, 75, 7),
            fontSize: 20,fontWeight: FontWeight.w400)),
           selectedTileColor: Colors.grey[350],
         
         
          selected: true,
           ),
    );
  }
}