import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Список')),
      body: ListView(
        children: [
          CheckboxListTile(
            value: true,
            onChanged: (_) {},
            title: Text('Title'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
