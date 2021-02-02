import 'package:flutter/material.dart';

import '../widgets/HeaderWidget.dart';

import '../colors.dart';

class EmptyScreen extends StatefulWidget {
  @override
  _EmptyScreenState createState() => new _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {

  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            HeaderWidget(),
            Positioned(
              top: 257,
              width: 120,
              height: 160,
              child: Image.asset(
                'assets/images/empty.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 492,
              child: Text(
                'No tasks',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: SPLASH_TITLE_COLOR,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              top: 529,
              width: 285,
              child: Text(
                'You have no task to do.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: SPLASH_TEXT_COLOR,
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
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
