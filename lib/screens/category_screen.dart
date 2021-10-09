import 'package:flutter/material.dart';

import '../widgets/group_name_widget.dart';
import '../widgets/header_widget.dart';
import '../models/category_model.dart';

import '../reposotories/todo_repository.dart';
import '../colors.dart';
import '../dummy_data.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => new _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = List.from(CategoryList);
  initState() {
    super.initState();
    todoCounts();
  }

  Future<void> todoCounts() async {
    for (int i = 0; i < categories.length; i++) {
      var j = await TodoRepository().todoCount(categories[i].id);
      setState((){
          categories[i].todoCount = j;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          SizedBox(
            height: 12,
          ),
          GroupNameWidget(groupName: 'Projects'),
          Container(
            width: double.infinity,
            height: size.height,
            margin: new EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
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
            todoLength(category.todoCount)
          ],
        ),
      ),
    );
  }

  Widget todoLength(todoCount) {
    String text;
    if(todoCount == 0){
      text = "No todos";
    }else if(todoCount == 1){
      text = "1 todo";
    }else{
      text = "$todoCount todos";
    }
    return Text(
      text,
      style: TextStyle(
        color: CATEGORY_ITEM_SUBTITLE_COLOR,
        fontSize: 10,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
