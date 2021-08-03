import 'package:flutter/material.dart';
import 'package:sample_todo_app/page/add_todo_page/add_todo_page.dart';
import 'package:sample_todo_app/page/todo_details_page/todo_details_page.dart';
import 'package:sample_todo_app/page/todo_list_page/todo_list_page.dart';

class AppRoute {
  static const todo_list = 'todo_list';
  static const todo_details = 'todo_details';
  static const add_todo = 'add_todo';
}

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.todo_list:
        return MaterialPageRoute(builder: (_) => TodoListPage());
      case AppRoute.todo_details:
        return MaterialPageRoute(builder: (_) => TodoDetailsPage());
      case AppRoute.add_todo:
        return MaterialPageRoute(builder: (_) => AddTodoPage());
    }
  }
}
