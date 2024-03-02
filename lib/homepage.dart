// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, no_logic_in_create_state, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/main.dart';
import 'package:task_1/PostModel.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/showvalue.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  List<PostModel> postlist = [];
  Future<List<PostModel>> getCommentsApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  var value_name;
  late SharedPreferences spget;

  void initState() {
    super.initState();

    getvalue();
  }

  void getvalue() async {
    spget = await SharedPreferences.getInstance();

    
    setState(() {
      value_name = spget.getString("name_value");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  spget.setBool('login_flag', true);
                  dispose();
                  Get.to(() => MyHomePage());
                },
                child: Text("Logout")),
          ],
          title: Text(
            "Username:-$value_name",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                // width: double.infinity,
                // height: double.infinity,
                child: FutureBuilder(
                  future: getCommentsApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                        "Loding.....",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: postlist.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.to(() => ShowValue(), arguments: {
                                    "id": postlist[index].id.toString(),
                                    "userid": postlist[index].userId.toString(),
                                    "title": postlist[index].title.toString(),
                                    "body": postlist[index].body.toString()
                                  });
                                },
                                
                                child: Card(
                                 
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: "Name:\n",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),TextSpan(text: 
                                              postlist[index].title.toString(),style:TextStyle(color: Colors.black))
                                            ])),
                                            subtitle:  RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: "Comments:\n",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),TextSpan(text: 
                                              postlist[index].body.toString(),style:TextStyle(color:Colors.black              ))
                                            ])),
                                            trailing: Text(
                                              postlist[index].id.toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      
                                    ),
                                  ),
                                ));
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
