import 'package:flutter/material.dart';
import 'package:sample_todo_app/config/app_router.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoute.todo_list,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
