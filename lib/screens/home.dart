import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marks_fine_accounting/constants/colors.dart';
import 'package:marks_fine_accounting/widgets/todo_item.dart';
import '../models/todo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todoList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();
  final _todoFocusNode = FocusNode();

  @override
  void initState(){
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: MyTheme.primaryColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 80),
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'All TODOs',
                          style: TextStyle(
                              color: MyTheme.textColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todoItem in _foundTodo.reversed)
                        TodoItem(
                          todo: todoItem,
                          onTodoChanged: _handleTodoChange,
                          onTodoDeleted: _handleTodoDelete,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          addItemBar()
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.done = !todo.done;
    });
  }

  void _handleTodoDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todoText) {
    setState(() {
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: todoText,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String keyword){
    List<Todo> result = [];
    if (keyword.isEmpty){
      result = todoList;
    } else {
      result = todoList.where((item) => item.text!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }

    setState(() {
      _foundTodo = result;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.clearColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16),
            prefixIcon:
            Icon(Icons.search, color: MyTheme.secondaryColor, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 45),
            border: InputBorder.none,
            isCollapsed: true,
            hintText: "Search"),
      ),
    );
  }

  Widget addItemBar(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: MyTheme.clearColor,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  onSubmitted: (text) {
                    _todoFocusNode.requestFocus();
                    _addTodoItem(text);
                  },
                  controller: _todoController,
                  focusNode: _todoFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none),
                ),
              )),
          Container(
            margin: const EdgeInsets.only(bottom: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                _addTodoItem(_todoController.text);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.accentColor,
                  minimumSize: Size(60, 60),
                  maximumSize: Size(60, 60),
                  elevation: 10),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: MyTheme.primaryColor,
      elevation: 0,
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu_rounded,
              color: MyTheme.secondaryColor, size: 30),
          SizedBox(
            width: 30,
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/images/avatar.png'),
            ),
          )
        ],
      ),
    );
  }
}
