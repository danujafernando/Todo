import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import './category_screen.dart';
import './todo_screen.dart';

import '../widgets/todo_add_widget.dart';

import '../colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  int _selectedIndex = 0;
  final List<Widget> viewContainer = [
    TodoScreen(),
    CategoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    animationController.forward();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showTodoAddModel(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: BARRIER_COLOR,
      isDismissible: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TodoAddWidget(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: viewContainer[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTodoAddModel(context);
        },
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
          child: Icon(
            Icons.add_rounded,
            size: 45,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BOTTOM_NAVIGATION_BAR_COLOR,
        selectedItemColor: FLOATING_BUTTON_SELECTED_ICON_COLOR,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Task',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
