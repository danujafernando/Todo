import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

import '../entities/todo_entity.dart';

@immutable
// ignore: must_be_immutable
class TodoModel extends Equatable {
  final String id;
  final String title;
  final String categoryId;
  final DateTime datetime;
  String note;
  bool notify;
  bool expire;

  TodoModel({
    @required this.id,
    @required this.title,
    @required this.categoryId,
    @required this.datetime,
    this.note,
    this.notify = false,
    this.expire = false,
  });

  @override
  List<Object> get props => [id, title, categoryId, datetime, note, notify, expire];

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        note = json['note'],
        datetime = DateTime.parse(json['datetime']),
        categoryId = json['categoryId'],
        notify = json['notify'],
        expire = json['expire'];

        
  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'datetime': datetime.toIso8601String(),
      'categoryId': categoryId,
      'notify': notify,
      'expire': expire
    };
  }

  TodoModel copyWith({bool notify, String id, String note, String task, String categoryId, bool expire}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note ?? this.note,
      datetime: datetime ?? this.datetime,
      categoryId: categoryId ?? this.categoryId,
      notify: notify ?? this.notify,
      expire: expire ?? this.expire
    );
  }
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      note: note,
      categoryId: categoryId,
      datetime: datetime,
      notify: notify,
      expire: expire
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
      expire: todo.expire ?? false
    );
  }

  static TodoModel fromSnapshot(DocumentSnapshot snap) {
    return TodoModel(
      id: snap.id,
      title: snap.data()['title'],
      note: snap.data()['note'],
      categoryId: snap.data()['categoryId'],
      datetime: snap.data()['datetime'].toDate(),
      notify: snap.data()['notify'],
      expire: snap.data()['expire'],
    );
  }
}
