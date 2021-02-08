import 'package:flutter/material.dart';

import './header_widget.dart';
import './todo_item_widget.dart';
import './group_name_widget.dart';


class TodoWidget extends StatefulWidget {
  final Function removeTodoItem;
  final Function notifyTodoItem;
  List todayTodoItems;
  List tomorrowTodoItems;

  TodoWidget({
    Key key,
    this.todayTodoItems,
    this.tomorrowTodoItems,
    this.removeTodoItem,
    this.notifyTodoItem,
  }) : super(key: key);

  @override
  _TodoWidgetState createState() => new _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {

  final GlobalKey<AnimatedListState> key = GlobalKey(); 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderWidget(
          height: 238,
        ),
        SizedBox(
          height: 12,
        ),
        (widget.todayTodoItems.length > 0) ? GroupNameWidget(groupName: 'Today') : Container(),
        todoList(widget.todayTodoItems, 1),
         (widget.tomorrowTodoItems.length > 0) ? GroupNameWidget(groupName: "Tomorrow") : Container(),
        todoList(widget.tomorrowTodoItems, 2),
      ],
    );
  }

  Widget buildTodoItem(
      toTodoItem, int index, int group) {
    return TodoItemWidget(
      todo: toTodoItem,
      onRemove: () => removeItem(index, group),
      onNotify: () => notifyItem(index, group),
    );
  }
  void removeItem(int index, int group) {
    widget.removeTodoItem(index, group);
  }

  void notifyItem(int index, int group) {
    widget.notifyTodoItem(index, group);
  }

  Widget todoList(List todoItem, int group){
    return Container(
      width: double.infinity,
      height: 80.0 * todoItem.length,
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
          itemCount: todoItem.length,
          itemBuilder: (ctx, index) {
            return buildTodoItem(todoItem[index], index, group);
          },
        ),
      ),
    );
  }
}
