import 'package:flutter/material.dart';

import '../art_works/TopLeftCircle.dart';
import '../art_works/TopRightCircle.dart';
import '../colors.dart';

class HeaderWidget extends StatelessWidget {
  double height;

  HeaderWidget({this.height = 106});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            HEADER_BOX_DARK_COLOR,
            HEADER_BOX_LIGHT_COLOR,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18.0,
            top: -18.0,
            child: TopRightCircle(),
          ),
          Positioned(
            left: -80.0,
            top: -105.0,
            child: TopLeftCircle(),
          ),
          Positioned(
            left: 18.0,
            top: 55.0,
            child: Text(
              'Hello Brenda!',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Rubik',
                color: HEADER_TITLE_COLOR,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            left: 18.0,
            top: 75.0,
            child: Text(
              'Today you have no tasks',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Rubik',
                color: HEADER_TITLE_COLOR,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            top: 30.0,
            child: Container(
              width: 94,
              height: 94,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/user.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
