import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/todos/todo_bloc.dart';

import '../widgets/todo_widget.dart';
import '../widgets/empty_widget.dart';

import '../models/todo_model.dart';

import '../dummy_data.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => new _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: addBloc(),
    );
  }

  Widget addBloc() {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        print(state);
      },
      builder: (BuildContext context, state) {
        if (state is TodoLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TodoNotLoaded) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is TodoLoaded) {
          final todos = state.todos;
          if (todos.isEmpty) {
            return EmptyWidget();
          } else {
            var now = new DateTime.now();
            var parseDate = now.add(new Duration(days: 1));
            var tomorrow =
                new DateTime(parseDate.year, parseDate.month, parseDate.day);
            final todayTodos = todos
                .where((todo) => todo.datetime.isBefore(tomorrow))
                .toList();
            final tomorrowTodos =
                todos.where((todo) => todo.datetime.isAfter(tomorrow)).toList();
            return TodoWidget(
              todayTodoItems: todayTodos,
              tomorrowTodoItems: tomorrowTodos,
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
