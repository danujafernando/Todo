import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Category{
  final String id;
  final String title;
  final IconData icon;
  final Color darkColor;
  final Color lightColor;

  const Category({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.darkColor,
    @required this.lightColor,
  });
}