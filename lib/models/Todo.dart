import 'package:flutter/foundation.dart';

class Todo{
  final String id;
  final String title;
  final String category_id;
  final DateTime datetime;
  bool notify;

  Todo({
    @required this.id,
    @required this.title,
    @required this.category_id,
    @required this.datetime,
    this.notify = false,
  });
}