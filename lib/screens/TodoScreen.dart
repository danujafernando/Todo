import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/TodoWidget.dart';
import '../widgets/EmptyWidget.dart';
import '../dummy_data.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => new _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List todayTodoItems;
  List tomorrowTodoItems;

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

  void removeTodoItem(int index, int group) {
    setState(() {
      if (group == 1) {
        todayTodoItems.removeAt(index);
      }
      if (group == 2) {
        tomorrowTodoItems.removeAt(index);
      }
    });
  }

  void notifyTodoItem(int index, int group){
    setState((){
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
      child: (todayTodoItems.length + tomorrowTodoItems.length > 0)
          ? TodoWidget(
              todayTodoItems: todayTodoItems,
              tomorrowTodoItems: tomorrowTodoItems,
              removeTodoItem: removeTodoItem,
              notifyTodoItem: notifyTodoItem,
            )
          : EmptyWidget(),
    );
  }
}
