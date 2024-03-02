// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ShowValue extends StatefulWidget {
  const ShowValue({super.key});

  @override
  State<ShowValue> createState() => _ShowValueState();
}

class _ShowValueState extends State<ShowValue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:Text("data value")
      
      ),
    body: 
       Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
        child: Column(
                                    

          children: [
        Text("ID:-,"+ Get.arguments['id'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),),
        Text("User_id:-"+ Get.arguments['userid'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),),
       Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Text( Get.arguments['title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),),
               Text("Body",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

        Text( Get.arguments['body'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),)
          
        ]),
        
        
        
        
        ),
      
    ),
    );
  }
}
