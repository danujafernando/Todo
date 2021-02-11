import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../entities/todo_entity.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final String categoryId;
  final DateTime datetime;
  String note;
  bool notify;

  TodoModel({
    @required this.id,
    @required this.title,
    @required this.categoryId,
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
      'categoryId': categoryId,
      'notify': notify
    };
  }

  TodoModel copyWith({bool notify, String id, String note, String task, String categoryId}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note ?? this.note,
      datetime: datetime ?? this.datetime,
      categoryId: categoryId ?? this.categoryId,
      notify: notify ?? this.notify
    );
  }
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      note: note,
      categoryId: categoryId,
      datetime: datetime,
      notify: notify
    );
  }

  static TodoModel fromEntity(TodoEntity todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      note: todo.note ?? null,
      categoryId: todo.categoryId,
      datetime: todo.datetime,
      notify: todo.notify ?? false,
    );
  }

  static TodoModel fromSnapshot(DocumentSnapshot snap) {
    return TodoModel(
      id: snap.id,
      title: snap.get('title'),
      note: snap.get('note'),
      categoryId: snap.get('categoryId'),
      datetime: snap.get('datetime').toDate(),
      notify: snap.get('notify'),
    );
  }
}
