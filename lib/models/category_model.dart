import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryModel{
  final String id;
  final String title;
  final IconData icon;
  final Color darkColor;
  final Color lightColor;
  int todoCount;

  CategoryModel({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.darkColor,
    @required this.lightColor,
    this.todoCount = 0,
  });
}