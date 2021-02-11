import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoEntity extends Equatable{

  final String id;
  final String title;
  final String categoryId;
  final DateTime datetime;
  String note;
  bool notify;

  TodoEntity({
    @required this.id,
    @required this.title,
    @required this.categoryId,
    @required this.datetime,
    this.note,
    this.notify = false,
  });
  
  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'categoryId': categoryId,
      'datetime': datetime,
      'notify': notify
    };
  }

  @override
  String toString() {
    return 'TodoEntity { datetime: $datetime, title: $title, note: $note, id: $id }';
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    return TodoEntity(
      id: snap.id,
      title: snap.get('title'),
      note: snap.get('note'),
      categoryId: snap.get('categoryId'),
      datetime: snap.get('datetime').toDate(),
      notify: snap.get('notify'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'categoryId': categoryId,
      'datetime': datetime,
      'notify': notify,  
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}