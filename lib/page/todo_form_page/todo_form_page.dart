import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/page/todo_form_page/form_field_wrapper.dart';
import 'package:sample_todo_app/page/todo_form_page/todo_form_state.dart';
import 'package:sample_todo_app/state/todo_list.dart';
import 'package:sample_todo_app/widget/date_time_field.dart';
import 'package:sample_todo_app/widget/save_dialog.dart';

class TodoFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TodoFormState _formState;

  TodoFormPage._({Key? key, required TodoFormState data})
      : _formState = data,
        super(key: key);

  factory TodoFormPage.add() {
    return TodoFormPage._(data: TodoFormState.create());
  }

  factory TodoFormPage.edit(Todo todo) {
    return TodoFormPage._(data: TodoFormState.fromModel(todo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _formState.mode == TodoFormMode.add ? 'Добавить' : 'Редактировать',
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_save(context)) Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: WillPopScope(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleField(),
                _buildDescriptionField(),
                _buildNotificationDateTimeField(),
              ],
            ),
          ),
        ),
        onWillPop: () => _onWillPop(context),
      ),
    );
  }

  FormFieldWrapper _buildNotificationDateTimeField() {
    return FormFieldWrapper(
      title: Text('Дата завершения'),
      field: DateTimeFormField(
        onSaved: (value) => _formState.notificationDateTime = value,
        initialValue: _formState.notificationDateTime ?? DateTime.now(),
        validator: (value) => value == null ? 'Заполните это поле' : null,
      ),
    );
  }

  Widget _buildDescriptionField() {
    return FormFieldWrapper(
      title: Text('Описание'),
      field: TextFormField(
        maxLines: 7,
        initialValue: _formState.description,
        onSaved: (value) => _formState.description = value,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Заполните это поле' : null,
      ),
    );
  }

  Widget _buildTitleField() {
    return FormFieldWrapper(
      title: Text('Название'),
      field: TextFormField(
        initialValue: _formState.title,
        onSaved: (value) => _formState.title = value,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Заполните это поле' : null,
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
    Provider.of<TodoList>(context, listen: false).save(_formState.toModel());

    return true;
  }
}
