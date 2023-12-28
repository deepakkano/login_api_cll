// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var name;
  var flagvalue;

  var emailvalue = TextEditingController();
  var phonevalue = TextEditingController();
  late SharedPreferences sp;
  late bool newuser;

  void initState() {
    super.initState();
    check_value_login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.lightBlue,
        // title: Text(widget.title),
          automaticallyImplyLeading: false,

      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            // color: Color.fromARGB(255, 235, 240, 247),
            color:Colors.lightBlue
            ),
        child: Align(
            alignment: Alignment.bottomCenter,

          child: Container(
            
            // margin: EdgeInsets.only(top: 245),
            padding: EdgeInsets.all(32),
            width: double.infinity,

            height: 500,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
                    
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome To Login Page",
                    style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/pic.png"),
                    backgroundColor: Color.fromARGB(255, 235, 240, 247),
                    radius: 50,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: emailvalue,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "Enter Your UserName",
                        prefixIcon: Icon(Icons.email_sharp)),
                  ),
                  TextField(
                    controller: phonevalue,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    obscureText: true,
                    maxLength: 10,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "Enter Your password",
                        prefixIcon: Icon(Icons.key_sharp)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String username = emailvalue.text.toString();
                        String password = phonevalue.text.toString();
                        //  print("email =$username and Password =$password");

                        if (username != '' && password != '') {
                          bool valid=EmailValidator.validate(username.trim());
                          if(valid){
                          sp.setBool("login_flag", false);
                          sp.setString("name_value", username);
                          Get.to(() => Homepage());
                                                        Get.snackbar("login","user-login",snackPosition: SnackPosition.BOTTOM);
}
                          else{
              Get.snackbar(""," Username Must be Email ",snackPosition: SnackPosition.BOTTOM);

                          }
                        }                    

                      },
                      child: Text(
                        "Sign in ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                ]),
          ),
        ),
      ),
    );
  }

  void check_value_login() async {
    sp = await SharedPreferences.getInstance();
    newuser = (sp.getBool('login_flag') ?? true);
    if (newuser == false) {
      Get.to(() => Homepage());
    }
  }

  void dispose() {
    emailvalue.dispose();
    phonevalue.dispose();
    super.dispose();
  }
}
