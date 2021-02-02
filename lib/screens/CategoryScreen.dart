import 'package:flutter/material.dart';

import '../widgets/GroupNameWiget.dart';
import '../widgets/HeaderWidget.dart';

import '../models/Category.dart';

import '../colors.dart';
import '../dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categories = List.from(CategoryList);
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(
            height: 238,
          ),
          SizedBox(
            height: 12,
          ),
          GroupNameWidget(groupName: 'Projects'),
          Container(
            width: double.infinity,
            height: size.height,
            margin: new EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              top: 18.0
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: setGridView(categories),
            ),
          ),
        ],
      ),
    );
  }

  Widget setGridView(categories) {
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, int index) {
        return Card(
          elevation: 8.0,
          child: setContainer(categories[index]),
        );
      },
    );
  }

  Widget setContainer(category) {
    return ClipPath(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CATEGORY_ITEM_BOX_COLOR,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: CATEGORY_ITEM_BOX_SHADOW_COLOR,
              blurRadius: 11,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: category.lightColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.icon,
                color: category.darkColor,
                size: 32,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Rubik',
                color: CATEGORY_ITEM_TITLE_COLOR,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '23 task',
              style: TextStyle(
                color: CATEGORY_ITEM_SUBTITLE_COLOR,
                fontSize: 10,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
