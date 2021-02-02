import 'package:flutter/material.dart';

import '../colors.dart';

class TopLeftCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 211,
      height: 211,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HEADER_LEFT_CIRCLE_COLOR
      ),
    );
  }
}
