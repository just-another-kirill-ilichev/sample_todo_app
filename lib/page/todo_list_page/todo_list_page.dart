import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/page/todo_list_page/todo_tile.dart';
import 'package:sample_todo_app/state/todo_list.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Список')),
      body: Consumer<TodoList>(
        builder: (ctx, todos, ___) => ListView.builder(
          itemCount: todos.items.length,
          itemBuilder: (_, idx) => TodoTile(todo: todos.items[idx]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoute.add_todo),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
