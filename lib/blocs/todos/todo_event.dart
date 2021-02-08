part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {

  const TodoEvent();

  @override
  List<Object> get props => [];

}

class LoadTodos extends TodoEvent {}

class LoadedTodos extends TodoEvent{}

class TodoAdded extends TodoEvent{
  final TodoModel todo;

  const TodoAdded(this.todo);

  @override
  List<Object> get props => [todo];

  @override 
  String toString() => 'TodoAdded { todo: $todo }';
}

class TodoUpdated extends TodoEvent{
  final TodoModel todo;

  const TodoUpdated(this.todo);

  @override
  List<Object> get props => [todo];

  @override 
  String toString() => 'TodoUpdated { todo: $todo }';
}
