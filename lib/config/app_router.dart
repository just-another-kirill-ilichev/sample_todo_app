import 'package:flutter/material.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/page/todo_form_page/todo_form_page.dart';
import 'package:sample_todo_app/page/todo_list_page/todo_list_page.dart';

class AppRoute {
  static const todo_list = 'todo_list';
  static const add_todo = 'add_todo';
  static const edit_todo = 'edit_todo';
}

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.todo_list:
        return MaterialPageRoute(builder: (_) => TodoListPage());
      case AppRoute.add_todo:
        return MaterialPageRoute(builder: (_) => TodoFormPage.add());
      case AppRoute.edit_todo:
        return MaterialPageRoute(
          builder: (_) => TodoFormPage.edit(settings.arguments as Todo),
        );
    }
  }
}
