import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/todo_model.dart';
import '../entities/todo_entity.dart';

class TodoRepository implements BasedTodoRepository {
  final todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(TodoModel todo) {
    return todoCollection.add(todo.toEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(TodoModel todo) {
    return todoCollection.doc(todo.id).delete();
  }

  @override
  Stream<List<TodoModel>> todos() {
    var now = new DateTime.now();
    var parseDate = now.add(new Duration(days: 2));
    var today = new DateTime(now.year, now.month, now.day);
    var tomorrow = new DateTime(parseDate.year, parseDate.month, parseDate.day);
    return todoCollection.where("datetime", isGreaterThanOrEqualTo: today).where("datetime", isLessThanOrEqualTo: tomorrow).orderBy('datetime').snapshots().map((snapshot){
      return snapshot.docs.map((doc) => TodoModel.fromEntity(TodoEntity.fromSnapshot(doc))).toList();
    });
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    return todoCollection.doc(todo.id).update(todo.toEntity().toDocument());
  }
}

abstract class BasedTodoRepository {

  Future<void> addNewTodo(TodoModel todo);

  Future<void> deleteTodo(TodoModel todo);

  Stream<List<TodoModel>> todos();

  Future<void> updateTodo(TodoModel todo);
}
