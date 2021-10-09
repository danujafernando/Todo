import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoEntity extends Equatable{

  final String id;
  final String title;
  final String categoryId;
  final DateTime datetime;
  String note;
  bool notify;
  bool expire;

  TodoEntity({
    @required this.id,
    @required this.title,
    @required this.categoryId,
    @required this.datetime,
    this.note,
    this.notify = false,
    this.expire = false
  });
  
  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'categoryId': categoryId,
      'datetime': datetime,
      'notify': notify,
      'expire': expire
    };
  }

  @override
  String toString() {
    return 'TodoEntity { datetime: $datetime, title: $title, note: $note, id: $id }';
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {

    return TodoEntity(
      id: snap.id,
      title: snap.data()['title'],
      note: snap.data()['note'],
      categoryId: snap.data()['categoryId'],
      datetime: snap.data()['datetime'].toDate(),
      notify: snap.data()['notify'],
      expire: snap.data()['expire'],
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
      'expire': expire  
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}