part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final Stream<List<TodoEntity>> todos;

  TodoLoadSuccess(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoLoadSuccess { todos: $todos }';
}

class TodoInitial extends TodoState {}

class TodosLoadFailure extends TodoState {}
