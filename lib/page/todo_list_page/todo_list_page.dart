import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/todo_list.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Список')),
      body: Consumer<TodoList>(
        builder: (ctx, todos, ___) => ListView.builder(
          itemCount: todos.items.length,
          itemBuilder: (_, idx) => ListTile(
            title: Text(todos.items[idx].title),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTest(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTest(BuildContext context) {
    Provider.of<TodoList>(context, listen: false)
        .add(Todo.create(DateTime.now(), 'Test', 'Test'));
  }
}
