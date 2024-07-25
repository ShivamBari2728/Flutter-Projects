// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:apitestapp/addUser.dart';
import 'package:apitestapp/drawerItems.dart';
import 'package:apitestapp/viewUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isloading = false;
  List<dynamic> userdata = [];
  Future<void> getData() async {
    setState(() {
      isloading = true;
    });
    var dio = Dio();
    try {
      Response response = await dio.get(
          "https://apptesting-a9f77-default-rtdb.firebaseio.com/users.json");

      userdata = response.data;
      isloading = false;
      setState(() {});
    } catch (e) {
      print("error occured");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.person_add_alt_1_outlined),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Adduser(
                  newindex: userdata.length,
                );
              })).then((value) {
                if (value == "refresh") {
                  getData();
                }
              });
            }),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Staff Manager"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                child: Icon(Icons.refresh),
                onTap: getData,
              ),
            )
          ],
        ),
        drawer: Draweritems(),
        body: RefreshIndicator(
          onRefresh: getData,
          //conditionally render widget dhow loading animation if data is loading .
          child: isloading
              //if
              ? Center(
                  child: CircularProgressIndicator(),
                )
              //else
              : ListView.builder(
                  itemCount: userdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    //check if the value is a Map or not because if we delete any value from
                    //database it will be null insted of removing completely.
                    return (userdata[index] is Map)
                        ? ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Viewuser(
                                  index: index,
                                  userstoredData: userdata[index],
                                );
                              })).then((value) {
                                if (value) {
                                  //if value is true then run get data. and value will be true when onDelete function will run
                                  getData(); //when user navigate back to main screen from new screen.
                                }
                              });
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userdata[index]["profile"]),
                            ),
                            trailing: Text("${userdata[index]["job"]}"),
                            title: Text(userdata[index]["username"] ?? [""]),
                            //fetch index from the list then the key within.
                          )
                        : SizedBox();
                  },
                ),
        ));
  }
}
