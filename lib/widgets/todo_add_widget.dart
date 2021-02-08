import 'package:Todo/blocs/blocs.dart';
import 'package:Todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/category_model.dart';

import '../dummy_data.dart';
import '../colors.dart';

class TodoAddWidget extends StatefulWidget {
  @override
  _TodoAddWidget createState() => _TodoAddWidget();
}

class _TodoAddWidget extends State<TodoAddWidget> {
  TextEditingController _titleEditingController = TextEditingController();
  List<CategoryModel> categories = List.from(CategoryList);
  FocusNode _focusNode = FocusNode();
  int _selectedIndex;
  String category_id;

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
    var title = _titleEditingController.text;
    TodoModel todo = TodoModel(
      id: 't2',
      title: title,
      note: null,
      category_id: category_id,
      datetime: new DateTime(2021, 2, 8, 17),
      notify: false,
    );

    final todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.add(TodoAdded(todo));
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
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 60,
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
                    Positioned(
                      top: 95,
                      left: 10,
                      right: 10,
                      child: titleEditorInput(size),
                    ),
                    Positioned(
                      top: 150,
                      left: 10,
                      right: 10,
                      child: categoryList(),
                    ),
                    Positioned(
                      top: 250,
                      left: 10,
                      right: 10,
                      child: FlatButton(
                        onPressed: () => {onSave()},
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width - 20,
                          height: 53,
                          margin: EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
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
                  category_id = categories[index].id;
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
