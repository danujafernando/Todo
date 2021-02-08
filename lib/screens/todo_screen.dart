import 'package:Todo/blocs/todos/todo_bloc.dart';
import 'package:Todo/entities/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/todo_widget.dart';
import '../widgets/empty_widget.dart';
import '../dummy_data.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => new _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List todayTodoItems;
  List tomorrowTodoItems;
  List<TodoEntity> todos;

  initState() {
    super.initState();
    var now = new DateTime.now();
    var formatDate = new DateFormat("yyyy-MM-dd").format(now);
    todayTodoItems = List.from(
      TodoList.where((items) =>
          (formatDate == DateFormat("yyyy-MM-dd").format(items.datetime))),
    );
    var tomorrow = now.add(new Duration(days: 1));
    var tomorrowFormatDate = new DateFormat("yyyy-MM-dd").format(tomorrow);
    tomorrowTodoItems = List.from(
      TodoList.where((items) => (tomorrowFormatDate ==
          DateFormat("yyyy-MM-dd").format(items.datetime))),
    );
  }

  void onRemoveTodoItem(int index, int group) {
    setState(() {
      if (group == 1) {
        todayTodoItems.removeAt(index);
      }
      if (group == 2) {
        tomorrowTodoItems.removeAt(index);
      }
    });
  }

  void onNotifyTodoItem(int index, int group) {
    setState(() {
      if (group == 1) {
        todayTodoItems[index].notify = !todayTodoItems[index].notify;
      }
      if (group == 2) {
        tomorrowTodoItems[index].notify = !tomorrowTodoItems[index].notify;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: addBloc(),
    );
  }

  Widget addBloc() {
    return BlocListener<TodoBloc, TodoState>(
      listener: (BuildContext context, TodoState state) {
        if (state is TodoLoadSuccess) {
          //print(state.todos);

          setState(() {
            state.todos.first.then((value) => todos = value);
          });
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (BuildContext context, TodoState state) {
          // if (state is TodoLoadInProgress) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // if (state is TodosLoadFailure) {
          //   return Center(
          //     child: Text('failed to fetch posts'),
          //   );
          // }
          // else {
          //   print(state);
          //   return Center(child: Text("Hello"));
          // }

          if (todos == null || todos.isEmpty) {
            return EmptyWidget();
          } else {
            print(todos);
            return TodoWidget(
              todayTodoItems: todos,
              tomorrowTodoItems: tomorrowTodoItems,
              removeTodoItem: onRemoveTodoItem,
              notifyTodoItem: onNotifyTodoItem,
            );
          }
        },
      ),
    );
  }
}
