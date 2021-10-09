part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todos;

  TodoLoaded([this.todos = const []]) : super();

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoLoaded { todos: $todos }';
}

class TodoInitial extends TodoState {}

class TodoNotLoaded extends TodoState {}
