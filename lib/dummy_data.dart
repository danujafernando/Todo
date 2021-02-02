import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './models/Category.dart';
import './models/Todo.dart';

List<Category> CategoryList = [
  Category(
    id: 'c1',
    title: 'Personal',
    icon: FontAwesomeIcons.user,
    darkColor: Color.fromRGBO(249, 194, 41, 1),
    lightColor: Color.fromRGBO(255, 238, 155, 0.36),
  ),
  Category(
    id: 'c2',
    title: 'Work',
    icon: Icons.work,
    darkColor: Color.fromRGBO(30, 209, 2, 1),
    lightColor: Color.fromRGBO(181, 255, 155, 0.36),
  ),
  Category(
    id: 'c3',
    title: 'Meeting',
    icon: FontAwesomeIcons.handshake,
    darkColor: Color.fromRGBO(209, 2, 99, 1),
    lightColor: Color.fromRGBO(255, 155, 205, 0.36),
  ),
  Category(
    id: 'c4',
    title: 'Shopping',
    icon: FontAwesomeIcons.shoppingCart,
    darkColor: Color.fromRGBO(236, 108, 11, 1),
    lightColor: Color.fromRGBO(255, 208, 155, 0.36),
  ),
  Category(
    id: 'c5',
    title: 'Party',
    icon: FontAwesomeIcons.glassCheers,
    darkColor: Color.fromRGBO(9, 172, 206, 1),
    lightColor: Color.fromRGBO(155, 255, 248, 0.36),
  ),
  Category(
    id: 'c6',
    title: 'Study',
    icon: FontAwesomeIcons.graduationCap,
    darkColor: Color.fromRGBO(191, 0, 128, 1),
    lightColor: Color.fromRGBO(245, 155, 255, 0.36),
  ),
];

// ignore: non_constant_identifier_names
List<Todo> TodoList = [
  Todo(
    id: 'td1',
    title: 'Go jogging with Christin',
    category_id: 'c1',
    datetime: new DateTime(2021, 2, 2, 7),
    notify: false,
  ),
  Todo(
    id: 'td2',
    title: 'Send project file',
    category_id: 'c2',
    datetime: new DateTime(2021, 2, 2, 7),
    notify: true,
  ),
  Todo(
    id: 'td3',
    title: 'Meeting with client',
    category_id: 'c3',
    datetime: new DateTime(2021, 2, 2, 8),
    notify: false,
  ),
  Todo(
    id: 'td4',
    title: 'Email client',
    category_id: 'c4',
    datetime: new DateTime(2021, 2, 2, 9),
    notify: false,
  ),
  Todo(
    id: 'td5',
    title: 'Morning yoga',
    category_id: 'c5',
    datetime: new DateTime(2021, 2, 2, 10),
    notify: false,
  ),
  Todo(
    id: 'td6',
    title: 'Email client',
    category_id: 'c6',
    datetime: new DateTime(2021, 2, 2, 11),
    notify: false,
  ),
  Todo(
    id: 'td7',
    title: 'Email client',
    category_id: 'c4',
    datetime: new DateTime(2021, 2, 3, 12),
    notify: false,
  ),
  Todo(
    id: 'td8',
    title: 'Morning yoga',
    category_id: 'c5',
    datetime: new DateTime(2021, 2, 3, 13),
    notify: false,
  ),
  Todo(
    id: 'td9',
    title: 'Email client',
    category_id: 'c6',
    datetime: new DateTime(2021, 2, 3, 14),
    notify: false,
  ),
  Todo(
    id: 'td10',
    title: 'Go jogging with Christin',
    category_id: 'c1',
    datetime: new DateTime(2021, 2, 3, 15),
    notify: false,
  ),
  Todo(
    id: 'td11',
    title: 'Send project file',
    category_id: 'c2',
    datetime: new DateTime(2021, 2, 3, 16),
    notify: true,
  ),
  Todo(
    id: 'td12',
    title: 'Meeting with client',
    category_id: 'c3',
    datetime: new DateTime(2021, 2, 3, 18),
    notify: false,
  ),
];
