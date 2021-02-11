import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/todo_model.dart';
import '../../reposotories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  StreamSubscription _todosSubscription;

  TodoBloc({@required TodoRepository todoRepository})
      : assert(todoRepository != null),
        _todoRepository = todoRepository, super(null);

  @override
  TodoState get initialState => TodoLoading();
  
  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodoToState();
    } else if (event is TodoAdd) {
      yield* _mapAddTodoToState(event);
    } else if (event is TodoUpdate) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is TodoDelete) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is TodoReceived) {
      yield* _mapTodoUpdateToState(event);
    } 
  }

  Stream<TodoState> _mapLoadTodoToState() async* {
    _todosSubscription?.cancel();
    _todosSubscription = _todoRepository.todos().listen((todos) => add(TodoReceived(todos)),);
  }

  Stream<TodoState> _mapAddTodoToState(TodoAdd event) async* {
    _todoRepository.addNewTodo(event.todo);
  }

  Stream<TodoState> _mapUpdateTodoToState(TodoUpdate event) async* {
    _todoRepository.updateTodo(event.todo);
  }

  Stream<TodoState> _mapDeleteTodoToState(TodoDelete event) async* {
    _todoRepository.deleteTodo(event.todo);
  }

  Stream<TodoState> _mapTodoUpdateToState(TodoReceived event) async* {
    yield TodoLoaded(event.todo);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
