// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/main.dart';

class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState() =>_HomePageState();
  

  }
 class _HomePageState extends State<Homepage> {
  @override
  var value_name;
  late SharedPreferences spget;



 void initState(){
super.initState();




getvalue();


 }
   void getvalue() async{
 spget=await SharedPreferences.getInstance();

print("shello baby i am here $value_name");
setState((){
value_name=spget.getString("name_value");

});

  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,

        title: Text("DashBoard Screen"),

      ),
      body:Center(
        child: Container(
          width:double.infinity,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
Text("Username:-$value_name" ,style: TextStyle(fontSize:30 ,fontWeight: FontWeight.bold
),),
ElevatedButton(onPressed: (){
  spget.setBool('login_flag',true);
  dispose();
Get.to(()=> MyHomePage());
}, child:Text("Logout"))


            
          ]),
        ),
      )
    );
  }

  }
  
 
 
 




  
  
 
