import 'package:flutter/material.dart';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/page/folder_form_page/folder_form_page.dart';
import 'package:sample_todo_app/page/folder_list_page/folder_list_page.dart';
import 'package:sample_todo_app/page/todo_form_page/todo_form_page.dart';
import 'package:sample_todo_app/page/todo_list_page/todo_list_page.dart';

class AppRoute {
  static const todo_list = 'todo_list';
  static const add_todo = 'add_todo';
  static const edit_todo = 'edit_todo';
  static const add_folder = 'add_folder';
  static const edit_folder = 'edit_folder';
  static const folder_list = 'folder_list';
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
      case AppRoute.add_folder:
        return MaterialPageRoute(builder: (_) => FolderFormPage.add());
      case AppRoute.edit_folder:
        return MaterialPageRoute(
          builder: (_) => FolderFormPage.edit(settings.arguments as Folder),
        );
      case AppRoute.folder_list:
        return MaterialPageRoute(builder: (_) => FolderListPage());
    }
  }
}
