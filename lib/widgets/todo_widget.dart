import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Todo/blocs/todos/todo_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './header_widget.dart';
import './todo_item_widget.dart';
import './group_name_widget.dart';

import '../models/todo_model.dart';

class TodoWidget extends StatefulWidget {
  List<TodoModel> todayTodoItems;
  List<TodoModel> tomorrowTodoItems;
  TodoWidget({Key key, this.todayTodoItems, this.tomorrowTodoItems})
      : super(key: key);

  @override
  _TodoWidgetState createState() => new _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final GlobalKey<AnimatedListState> key = GlobalKey();
  Timer timer;

  void initState() {
    super.initState();
    updateExpire();
    timer = new Timer.periodic(Duration(seconds: 15), (Timer t) => updateExpire()); 
  }

  Future<void> updateExpire() async {
    var now = new DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<TodoModel> notifyTodoItems = [];
    for (var i = 0; i < this.widget.todayTodoItems.length; i++) {
      TodoModel todo = this.widget.todayTodoItems[i];
      if (!todo.expire) {
        var todoDateTime = todo.datetime;
        bool isBefore = todoDateTime.isBefore(now);
        if (isBefore) {
          BlocProvider.of<TodoBloc>(context).add(
            TodoUpdate(
              todo.copyWith(expire: true),
            ),
          );
        }else{
          if(todo.notify){
            notifyTodoItems.add(todo);
          }
        }
      }
    }
    prefs.setString('notifyTodos', json.encode(notifyTodoItems));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderWidget(),
        SizedBox(
          height: 12,
        ),
        (widget.todayTodoItems.length > 0)
            ? GroupNameWidget(groupName: 'Today')
            : Container(),
        todoList(widget.todayTodoItems, 1),
        (widget.tomorrowTodoItems.length > 0)
            ? GroupNameWidget(groupName: "Tomorrow")
            : Container(),
        todoList(widget.tomorrowTodoItems, 2),
      ],
    );
  }

  Widget buildTodoItem(TodoModel todoItem) {
    return TodoItemWidget(
      todo: todoItem,
      onRemove: () => removeItem(todoItem),
    );
  }

  void removeItem(TodoModel todo) {
    BlocProvider.of<TodoBloc>(context).add(TodoDelete(todo));
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Deleted ${todo.title}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => BlocProvider.of<TodoBloc>(context).add(
            TodoAdd(
              todo,
            ),
          ),
        ),
      ),
    );
  }

  void notifyItem(TodoModel todo) {
    BlocProvider.of<TodoBloc>(context).add(
      TodoUpdate(
        todo.copyWith(notify: !todo.notify),
      ),
    );
  }

  Widget todoList(List<TodoModel> todoItems, int group) {
    return Container(
      width: double.infinity,
      height: 80.0 * todoItems.length,
      padding: const EdgeInsets.only(
        top: 18.0,
      ),
      margin: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: todoItems.length,
          itemBuilder: (ctx, index) {
            return buildTodoItem(todoItems[index]);
          },
        ),
      ),
    );
  }
}
