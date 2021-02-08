import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Stream<List<TodoEntity>> todos() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TodoEntity.fromSnapshot(doc)).toList();
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

  Stream<List<TodoEntity>> todos();

  Future<void> updateTodo(TodoModel todo);
}
