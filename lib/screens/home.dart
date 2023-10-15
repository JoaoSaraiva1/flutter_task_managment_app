// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../model/task.dart';
import '../utils/colors.dart';
import '../widgets/task_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final taskList = Task.taskList();
  List<Task> _foundTasks = [];
  final _taskControler = TextEditingController();

  @override
  void initState() {
    _foundTasks = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tmBGWhite,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 20),
                      child: Center(
                        child: Text(
                          'My Tasks',
                          style: TextStyle(
                              color: tmBlack,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    for (Task task in _foundTasks.reversed)
                      TaskItem(
                        task: task,
                        onTaskChanged: _handleTaskChanged,
                        onDeleteItem: _deleteTask,
                      ),
                  ]),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: tmBGWhite,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _taskControler,
                        decoration: InputDecoration(
                          hintText: "Add a new Task",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, right: 20),
                    child: ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                      onPressed: () {
                        _addTask(_taskControler.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tmBGColor,
                        minimumSize: Size(60, 60),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ));
  }

  void _handleTaskChanged(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _deleteTask(String id) {
    setState(() {
      taskList.removeWhere((task) => task.id == id);
    });
  }

  void _addTask(String task) {
    setState(() {
      taskList.add(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        taskText: task,
      ));
    });
    _taskControler.clear();
  }

  void _searchTask(String keyword) {
    List<Task> results = [];
    if (keyword.isEmpty) {
      results = taskList;
    } else {
      results = taskList
          .where((task) =>
              task.taskText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTasks = results;
    });
  }

  Widget searchBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _searchTask(value),
        decoration: InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tmBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tmBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
          )
        ],
      ),
    );
  }
}
