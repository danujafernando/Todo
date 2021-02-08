import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoEntity extends Equatable{

  final String id;
  final String title;
  final String category_id;
  final DateTime datetime;
  String note;
  bool notify;

  TodoEntity({
    @required this.id,
    @required this.title,
    @required this.category_id,
    @required this.datetime,
    this.note,
    this.notify = false,
  });
  
  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'category_id': category_id,
      'datetime': datetime,
      'notify': notify
    };
  }

  @override
  String toString() {
    return 'TodoEntity { datetime: $datetime, title: $title, note: $note, id: $id }';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      note: json['note'] as String,
      category_id: json['category_id'] as String,
      datetime: json['datetime'] as DateTime,
      notify: json['notify'] as bool,
    );
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    return TodoEntity(
      id: snap.id,
      title: snap.get('title'),
      note: snap.get('note'),
      category_id: snap.get('category_id'),
      datetime: snap.get('datetime').toDate(),
      notify: snap.get('notify'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'category_id': category_id,
      'datetime': datetime,
      'notify': notify,  
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}