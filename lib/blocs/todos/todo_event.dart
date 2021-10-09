part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable{

  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {}

class LoadedTodos extends TodoEvent{}

class TodoAdd extends TodoEvent{
  final TodoModel todo;

  const TodoAdd(this.todo);

  @override
  List<Object> get props => [todo];

  @override 
  String toString() => 'TodoAdded { todo: $todo }';
}

class TodoUpdate extends TodoEvent {
  final TodoModel todo;

  const TodoUpdate(this.todo);
  
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'UpdateTodo { updatedTodo: $todo }';
}


class TodoDelete extends TodoEvent {
  final TodoModel todo;

  const TodoDelete(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'DeleteTodo { todo: $todo }';
}

class TodoReceived extends TodoEvent{
  final List<TodoModel> todo;

  const TodoReceived(this.todo);

  @override
  List<Object> get props => [todo];
}

class GetAllTodos extends TodoEvent {
  @override
  List<Object> get props => [];
}
