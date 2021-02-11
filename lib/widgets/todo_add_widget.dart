import 'package:Todo/blocs/blocs.dart';
import 'package:Todo/models/todo_model.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../models/category_model.dart';

import '../dummy_data.dart';
import '../colors.dart';

class TodoAddWidget extends StatefulWidget {
  @override
  _TodoAddWidget createState() => _TodoAddWidget();
}

class _TodoAddWidget extends State<TodoAddWidget> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _noteEditingController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime selectedDate;
  List<CategoryModel> categories = List.from(CategoryList);
  FocusNode _focusNode = FocusNode();
  int _selectedIndex;
  String categoryId;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleEditingController.dispose();
    super.dispose();
  }

  void onSave() {
    try {
      var title = _titleEditingController.text;
      var note = _noteEditingController.text;
      if (title == null || title == '' || categoryId == null || selectedDate == null) {
        var errorMessage = "";
        if(title == null || title == ''){
          errorMessage += "Title is missing \n";
        }
        if(categoryId == null){
          errorMessage += "Category is missing \n";
        }
        if(selectedDate == null){
          errorMessage += "Date & time is missing";
        }
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: errorMessage,
        );
      } else {
        TodoModel todo = TodoModel(
          id: 't2',
          title: title,
          note: note,
          categoryId: categoryId,
          datetime: selectedDate,
          notify: false,
        );
        final todoBloc = BlocProvider.of<TodoBloc>(context);
        todoBloc.add(TodoAdd(todo));
        Navigator.pop(context);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 125,
            left: 0,
            width: size.width,
            height: size.height,
            child: ClipPath(
              clipper: ClipPainter(),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 60,
                      ),
                      child: Text(
                        'Add new task',
                        style: TextStyle(
                          color: TODO_ITEM_ADD_TITLE,
                          fontSize: 16,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    titleEditorInput(size),
                    noteEditorInput(size),
                    categoryList(),
                    dateTimeInput(size),
                    Container(
                      child: FlatButton(
                        onPressed: () => {onSave()},
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width - 20,
                          height: 53,
                          margin: EdgeInsets.only(left: 25, right: 25, top: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors: <Color>[
                                TODO_ITEM_ADD_BUTTON_LIGHT_COLOR,
                                TODO_ITEM_ADD_BUTTON_DARK_COLOR
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: TODO_ITEM_ADD_BUTTON_SHADOW_COLOR,
                                blurRadius: 39,
                                offset: Offset(0, 7),
                              ),
                            ],
                          ),
                          child: Text(
                            'Add task',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          closeButton(context),
        ],
      ),
    );
  }

  Widget categoryList() {
    return Container(
      height: 70.0,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, int index) {
          return ChoiceChip(
            selected: _selectedIndex == index,
            label: Text(
              categories[index].title,
              style: TextStyle(
                color: (_selectedIndex != index)
                    ? Color.fromRGBO(142, 142, 142, 1)
                    : Colors.white,
                fontFamily: 'Rubik',
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            avatar: (_selectedIndex != index)
                ? Icon(
                    Icons.fiber_manual_record,
                    color: categories[index].darkColor,
                  )
                : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: Colors.white,
            elevation: (_selectedIndex != index) ? 0 : 4,
            selectedColor:
                (_selectedIndex == index) ? categories[index].darkColor : null,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _selectedIndex = index;
                  categoryId = categories[index].id;
                }
              });
            },
          );
        },
      ),
    );
  }

  Widget titleEditorInput(size) {
    return Container(
      width: size.width - 20,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: TextFormField(
        autofocus: true,
        obscureText: false,
        keyboardType: TextInputType.text,
        controller: _titleEditingController,
        focusNode: _focusNode,
        style: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(161, 161, 161, 1),
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          hintText: "Title",
          hintStyle: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(161, 161, 161, 1),
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Color.fromRGBO(224, 224, 224, 1),
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Color.fromRGBO(224, 224, 224, 1),
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  Widget noteEditorInput(size) {
    return Container(
      width: size.width - 20,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: TextFormField(
        autofocus: true,
        obscureText: false,
        keyboardType: TextInputType.multiline,
        controller: _noteEditingController,
        focusNode: _focusNode,
        maxLength: null,
        maxLines: 5,
        style: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(161, 161, 161, 1),
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          hintText: "Note",
          hintStyle: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(161, 161, 161, 1),
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Color.fromRGBO(224, 224, 224, 1),
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Color.fromRGBO(224, 224, 224, 1),
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  Widget dateTimeInput(size) {
    return Container(
      width: size.width - 20,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: DateTimeField(
        format: format,
        initialValue: selectedDate,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            setState(() {
              selectedDate = DateTimeField.combine(date, time);
            });
            return DateTimeField.combine(date, time);
          } else {
            setState(() {
              selectedDate = currentValue;
            });
            return currentValue;
          }
        },
        decoration: InputDecoration(
          hintText: "Date & Time",
          hintStyle: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(161, 161, 161, 1),
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w300,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Color.fromRGBO(224, 224, 224, 1),
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Color.fromRGBO(224, 224, 224, 1),
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  Widget closeButton(context) {
    return Positioned(
      top: 95.0,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[
                FLOATING_ACTION_BUTTON_LIGHT_COLOR,
                FLOATING_ACTION_BUTTON_DARK_COLOR
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: FLOATING_ACTION_BUTTON_SHADOW_COLOR,
                blurRadius: 39,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: Icon(Icons.close_rounded, size: 45, color: Colors.white),
        ),
      ),
    );
  }
}

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var height = size.height;
    var width = size.width;

    var path = new Path();
    path.moveTo(0, 30);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 30);
    path.moveTo(0, 30);
    path.quadraticBezierTo(size.width / 2, -30, size.width, 30);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
