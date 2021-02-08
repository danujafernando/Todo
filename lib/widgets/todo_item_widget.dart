import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../dummy_data.dart';
import '../models/todo_model.dart';

import '../colors.dart';

class TodoItemWidget extends StatelessWidget {
  TodoModel todo;
  final VoidCallback onRemove;
  final VoidCallback onNotify;

  TodoItemWidget({
    Key key,
    @required this.todo,
    @required this.onRemove,
    @required this.onNotify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todoDismissible();
  }

  Widget todoDismissible() {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => { onRemove() },
      background: Container(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        alignment: Alignment.topRight,
        child: Container(
          width: 35,
          height: 35,
          margin: const EdgeInsets.only(
            top: 11.0,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: TODO_ITEM_DELETE_BG_COLOR,
            boxShadow: [
              BoxShadow(
                color: TODO_ITEM_DELETE_BG_SHADOW_COLOR,
              ),
            ],
          ),
          child: Icon(
            Icons.delete,
            color: TODO_ITEM_DELETE_COLOR,
          ),
        ),
      ),
      child: todoItemCard(),
    );
  }

  Widget todoItemCard() {
    return Card(
      margin: const EdgeInsets.only(
        left: 0.0,
        right: 0.0,
        bottom: 18.0,
      ),
      elevation: 2,
      child: todoContainer(),
    );
  }

  Widget todoContainer() {
    var now = new DateTime.now();
    var todoDateTime = todo.datetime;
    bool isBefore = todoDateTime.isBefore(now);
    return ClipPath(
      child: Container(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        height: 55.0,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color:
                  CategoryList.firstWhere((item) => item.id == todo.category_id)
                      .darkColor,
              width: 5,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            toTodoCompleted(isBefore),
            toTodoTime(),
            toTodoTitle(isBefore),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => { onNotify() },
                child: Icon(
                  Icons.notifications,
                  size: 18,
                  color: (todo.notify)
                      ? TODO_ITEM_NOTIFICATION_ON_COLOR
                      : TODO_ITEM_NOTIFICATION_OFF_COLOR,
                ),
              ),
            ),
          ],
        ),
      ),
      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget toTodoCompleted(isBefore) {
    return Positioned(
      child: Icon(
        (!isBefore) ? FontAwesomeIcons.circle : Icons.check_circle,
        size: 18,
        color: (!isBefore) ? TODO_ITEM_UNTICK_COLOR : TODO_ITEM_TICK_COLOR,
      ),
    );
  }

  Widget toTodoTime() {
    String formatDate = new DateFormat("hh.mm a").format(todo.datetime);
    return Positioned(
      left: 25,
      child: Text(
        formatDate,
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 11,
          color: TODO_ITEM_TIME_COLOR,
        ),
      ),
    );
  }

  Widget toTodoTitle(isBefore) {
    return Positioned(
      left: 80,
      child: Text(
        todo.title,
        style: TextStyle(
          color: (!isBefore)
              ? TODO_ITEM_TITLE_COLOR
              : TODO_ITEM_EXPIRED_TITLE_COLOR,
          fontFamily: 'Rubik',
          fontWeight: (!isBefore) ? FontWeight.w500 : FontWeight.w300,
          fontSize: 14,
          decoration:
              (!isBefore) ? TextDecoration.none : TextDecoration.lineThrough,
          decorationThickness: 3,    
        ),
      ),
    );
  }
}
