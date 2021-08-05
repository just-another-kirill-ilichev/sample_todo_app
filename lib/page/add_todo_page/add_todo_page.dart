import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/todo_list.dart';
import 'package:sample_todo_app/widget/date_time_field.dart';
import 'package:sample_todo_app/widget/save_dialog.dart';

class _TodoFormData {
  String? title;
  String? description;
  DateTime? notificationDateTime;

  _TodoFormData({this.title, this.description, this.notificationDateTime});

  factory _TodoFormData.fromTodo(Todo todo) {
    return _TodoFormData(
      title: todo.title,
      description: todo.description,
      notificationDateTime: todo.notificationDateTime,
    );
  }

  factory _TodoFormData.create() {
    var now = DateTime.now();
    var notificationDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    ).add(Duration(days: 1));

    return _TodoFormData(notificationDateTime: notificationDateTime);
  }
}

class AddTodoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formData = _TodoFormData.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить'),
        actions: [
          IconButton(
              onPressed: () {
                if (_save(context)) Navigator.pop(context);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: WillPopScope(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onSaved: (value) => _formData.title = value,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Заполните это поле' : null,
              ),
              TextFormField(
                onSaved: (value) => _formData.description = value,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Заполните это поле' : null,
              ),
              DateTimeFormField(
                onSaved: (value) => _formData.notificationDateTime = value,
                initialValue: DateTime.now(),
                validator: (value) =>
                    value == null ? 'Заполните это поле' : null,
              ),
            ],
          ),
        ),
        onWillPop: () => _onWillPop(context),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    SaveDialogResult result =
        await showPlatformSaveDialog(context, (_) => SaveDialog());

    switch (result) {
      case SaveDialogResult.save:
        return _save(context);
      case SaveDialogResult.discard:
        return true;
      case SaveDialogResult.cancel:
        return false;
    }
  }

  bool _save(BuildContext context) {
    var validationResult = _formKey.currentState?.validate() ?? false;

    if (!validationResult) {
      return false;
    }

    _formKey.currentState?.save();

    Provider.of<TodoList>(context, listen: false).add(Todo(
      creationDate: DateTime.now(),
      notificationDateTime: _formData.notificationDateTime!,
      title: _formData.title!,
      description: _formData.description!,
      finished: false,
    ));

    return true;
  }
}
