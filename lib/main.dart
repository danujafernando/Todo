import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import 'blocs/todos/todo_bloc.dart';
import 'reposotories/todo_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyTodoApp());
}

class MyTodoApp extends StatefulWidget {
  @override
  _MyTodoApp createState() => _MyTodoApp();
}

class _MyTodoApp extends State<MyTodoApp> with SingleTickerProviderStateMixin {
  // This widget is the root of your application.
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) {
          return TodoBloc(
            todoRepository: TodoRepository(),
          )..add(LoadTodos());
        },
        child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
