// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/addTodo.dart';

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
    setState(() {
      ToDoList.insert(0, todotext);
    });
    updateList();
    Navigator.pop(
        context); //this is use to close the slidesheet and show the home screen. it is like a back button.
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
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('TODO App'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 44, 44, 44),
        actions: [
          InkWell(
            enableFeedback: true,
            splashColor: Color.fromARGB(255, 184, 212, 243),
            onTap: () {
              showModalBottomSheet(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
        //backgroundColor: Color.fromARGB(255, 105, 105, 105),
      ),
      body: ListView.builder(
          itemCount: ToDoList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(ToDoList[index]),
              leading: Icon(Icons.fiber_manual_record_outlined),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 172, 6),
                          ),
                          child: Text(
                            "Mark as Done",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              ToDoList.removeAt(index);
                            });
                            updateList();
                            Navigator.pop(context);
                          },
                        ),
                      );
                    });
              },
            );
          }),
    );
  }
}
