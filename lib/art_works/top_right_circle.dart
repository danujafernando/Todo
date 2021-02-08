import 'package:flutter/material.dart';

import '../colors.dart';

class TopRightCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 93,
      height: 93,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HEADER_RIGHT_CIRCLE_COLOR
      ),
    );
  }
}
