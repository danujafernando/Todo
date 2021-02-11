import 'package:Todo/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 175,
                child: Image.asset(
                  'assets/images/splash_bg.png',
                  height: 201,
                  width: 186,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 492,
                child: Text(
                  'Reminders made simple',
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
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque erat in blandit luctus.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: SPLASH_TEXT_COLOR,
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              Positioned(
                top: 681,
                width: 258,
                height: 56,
                child: InkWell(
                  onTap: () => {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        )
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          SPLASH_BUTTON_DARK_COLOR,
                          SPLASH_BUTTON_LIGHT_COLOR
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: SPLASH_BUTTON_SHADOW_COLOR,
                          blurRadius: 30,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                          color: SPLASH_BUTTON_TEXT_COLOR,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
