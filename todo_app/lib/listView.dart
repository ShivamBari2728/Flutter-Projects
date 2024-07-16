// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class listView extends StatefulWidget {
  void Function() updateList;
  List<String> ToDoList;
  listView({super.key, required this.ToDoList, required this.updateList});

  @override
  State<listView> createState() => _listViewState();
}

class _listViewState extends State<listView> {
  @override
  Widget build(BuildContext context) {
    return (widget
            .ToDoList.isEmpty) //if else to return widget based on condition
        ? Container(
            color: Color.fromARGB(255, 58, 58, 58),
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 115,
                  ),
                  Icon(Icons.checklist_rounded),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "No remaining task!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        : Container(
            color: Color.fromARGB(255, 58, 58, 58),
            child: ListView.builder(
                itemCount: widget.ToDoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    //give functon to dismiss a widget withswipe.
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.green,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.check_box),
                          ),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        widget.ToDoList.removeAt(index);
                      });
                      widget.updateList();
                    },

                    //actual list view.
                    child: ListTile(
                      title: Text(widget.ToDoList[index]),
                      leading: Icon(Icons.fiber_manual_record_outlined),
                      //on clicking any item on list.
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 0, 172, 6),
                                  ),
                                  child: Text(
                                    "Mark as Done",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.ToDoList.removeAt(index);
                                    });
                                    widget.updateList();
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            });
                      }, //ontap
                    ),
                  );
                }),
          );
  }
}
