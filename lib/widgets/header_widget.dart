import 'dart:async';
import 'dart:convert';

import 'package:Todo/blocs/todos/todo_bloc.dart';
import 'package:Todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../art_works/top_left_circle.dart';
import '../art_works/top_right_circle.dart';
import '../colors.dart';

class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidgetState createState() => new _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  Timer timer;
  var notifyTodos;
  var decodeNotifyTodo;
  List todos = [];
  double height = 106;

  @override
  void initState() {
    super.initState();
    getNotifyModel();
    timer = new Timer.periodic(
        Duration(seconds: 15), (Timer t) => getNotifyModel());
  }

  void getNotifyModel() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    notifyTodos = localStorage.getString('notifyTodos');
    if (notifyTodos != null) {
      setState(() {
        todos = json.decode(notifyTodos);
        if (todos.length > 0) {
          height = 231;
        } else {
          height = 106;
        }
      });
    } else {
      setState(() {
        todos = [];
        height = 106;
      });
    }
  }

  void removeNotifyItem(todoModel, index){
      BlocProvider.of<TodoBloc>(context).add(
        TodoUpdate(
          todoModel.copyWith(notify: !todoModel.notify),
        ),
      );
      setState(() {
        todos.removeAt(index);
        if(todos.length == 0){
          height = 106;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            HEADER_BOX_DARK_COLOR,
            HEADER_BOX_LIGHT_COLOR,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18.0,
            top: -18.0,
            child: TopRightCircle(),
          ),
          Positioned(
            left: -80.0,
            top: -105.0,
            child: TopLeftCircle(),
          ),
          Positioned(
            left: 18.0,
            top: 55.0,
            child: Text(
              'Hello Brenda!',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Rubik',
                color: HEADER_TITLE_COLOR,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            left: 18.0,
            top: 75.0,
            child: Text(
              'Today you have no tasks',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Rubik',
                color: HEADER_TITLE_COLOR,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            top: 30.0,
            child: Container(
              width: 94,
              height: 94,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/user.png'),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 10.0,
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                return notifyTodoItem(todos[index], index, size);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget notifyTodoItem(todo, index, size) {
    TodoModel todoModel = TodoModel.fromJson(todo);
    String formatDate =
        new DateFormat("hh.mm a").format(DateTime.parse(todo['datetime']));
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      width: size.width - 40,
      decoration: BoxDecoration(
        color: TODO_NOTIFY_BG_COLOR,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15.0,
            top: 25.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today Reminder",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  todo['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Text(
                  formatDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 25.0,
            right: 20.0,
            child: Transform.rotate(
              angle: 45,
              child: Container(
                width: 65,
                height: 80,
                child: Image.asset(
                  'assets/images/bell.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5.0,
            right: 5.0,
            child: GestureDetector(
              onTap: () => {
                removeNotifyItem(todoModel, index)
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
