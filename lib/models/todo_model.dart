import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/todo_entity.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final String category_id;
  final DateTime datetime;
  String note;
  bool notify;

  TodoModel({
    @required this.id,
    @required this.title,
    @required this.category_id,
    @required this.datetime,
    this.note,
    this.notify = false,
  });

  @override
  List<Object> get props => [];

  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'datetime': datetime,
      'category_id': category_id,
      'notify': notify
    };
  }

  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      note: note,
      category_id: category_id,
      datetime: datetime,
      notify: notify
    );
  }

  static TodoModel fromEntity(TodoEntity todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      note: todo.note ?? null,
      category_id: todo.category_id,
      datetime: todo.datetime,
      notify: todo.notify ?? false,
    );
  }

  static TodoModel fromSnapshot(DocumentSnapshot snap) {
    return TodoModel(
      id: snap.id,
      title: snap.get('title'),
      note: snap.get('note'),
      category_id: snap.get('category_id'),
      datetime: snap.get('datetime').toDate(),
      notify: snap.get('notify'),
    );
  }
}
