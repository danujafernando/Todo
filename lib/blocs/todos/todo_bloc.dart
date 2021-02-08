import 'dart:async';
import 'package:Todo/entities/todo_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/todo_model.dart';
import '../../reposotories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc({@required TodoRepository todoRepository})
      : assert(todoRepository != null),
        _todoRepository = todoRepository,
        super(null);

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodoToState();
    } else if (event is TodoAdded) {
      yield* _mapAddTodoToState(event);
    }
  }

  Stream<TodoState> _mapLoadTodoToState() async* {
    List<TodoEntity> todoList;
    try {
      var todos = _todoRepository.todos();
      //
      // todos.listen((event) {
      //   todoList = event;
      // });

      yield TodoLoadSuccess(todos);
    } catch (_) {
      yield TodosLoadFailure();
    }
  }

  @override
  TodoState get initialState => TodoLoadInProgress();

  Stream<TodoState> _mapAddTodoToState(TodoAdded event) async* {
    _todoRepository.addNewTodo(event.todo);
  }
}
