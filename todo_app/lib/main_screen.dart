// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/addTodo.dart';
import 'package:todo_app/drawerItems.dart';
import 'package:todo_app/listView.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> ToDoList = [];
  @override
  void initState() {
    super.initState();
    loadList();
  }

  void addToDo({required String todotext}) {
    if (ToDoList.contains(todotext)) {
      //to check if item alresy exist if yes then  show a alert box.
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Item Already Exist!"),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
                )
              ],
            );
          });
    } else {
      setState(() {
        ToDoList.insert(0, todotext);
      });
      updateList();
      Navigator.pop(
          context); //this is use to close the slidesheet and show the home screen. it is like a back button.
    }
  }

  void updateList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Obtain shared preferences.
    await prefs.setStringList('ToDoList', ToDoList);
  }

  void loadList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ToDoList = (prefs.getStringList("ToDoList") ?? []).toList();
    setState(() {});
  }

//ui elements
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Color.fromARGB(255, 58, 58, 58),
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  //to resize padding of bottom sheet so that keyboard wont hide the text field and button.

                  child: Container(
                      height: 250,
                      padding: EdgeInsets.all(30),
                      child: Addtodo(
                        sendtext:
                            addToDo, //sending function to constructor of addtodo class.
                      )),
                );
              });
        },
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

      drawer: Draweritems(), //seprate file for drawer.

      appBar: AppBar(
        title: Text('Listify' ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 119, 119, 119),

        // below code is used to show icons or text on app bar. Inkwell is use to add on tap functionality to the elements.

        // actions: [
        //   InkWell(
        //     enableFeedback: true,
        //     splashColor: Color.fromARGB(255, 184, 212, 243),
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Icon(Icons.add), // add icon
        //     ),
        //     onTap: () {
        //       showModalBottomSheet(
        //           context: context,
        //           builder: (context) {
        //             return Padding(
        //               padding: MediaQuery.of(context).viewInsets,
        //               //to resize padding of bottom sheet so that keyboard wont hide the text field and button.

        //               child: Container(
        //                   height: 250,
        //                   padding: EdgeInsets.all(30),
        //                   child: Addtodo(
        //                     sendtext:
        //                         addToDo, //sending function to constructor of addtodo class.
        //                   )),
        //             );
        //           });
        //     },
        //   )
        // ],
        //backgroundColor: Color.fromARGB(255, 105, 105, 105),
      ),
      body: listView(
        ToDoList: ToDoList,
        updateList: updateList,
      ),
      //View the list on home page
    );
  }
}
