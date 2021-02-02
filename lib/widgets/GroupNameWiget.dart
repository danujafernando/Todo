import 'package:flutter/material.dart';

import '../colors.dart';

class GroupNameWidget extends StatelessWidget{

  String groupName;

  GroupNameWidget({
    Key key,
    @required this.groupName,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
          ),
          child: Text(
            groupName,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              color: TODO_LIST_TITLE_COLOR,
            ),
          ),
        ),
      ],
    );
  }
  
}