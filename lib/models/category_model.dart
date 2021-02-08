import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryModel{
  final String id;
  final String title;
  final IconData icon;
  final Color darkColor;
  final Color lightColor;

  const CategoryModel({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.darkColor,
    @required this.lightColor,
  });
}