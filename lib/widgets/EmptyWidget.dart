import 'package:flutter/material.dart';

import '../widgets/HeaderWidget.dart';

import '../colors.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
    );
  }
}
