import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/page/todo_form_page/form_field_wrapper.dart';
import 'package:sample_todo_app/page/todo_form_page/todo_form_state.dart';
import 'package:sample_todo_app/state/todo_list.dart';
import 'package:sample_todo_app/widget/custom_form_scaffold.dart';
import 'package:sample_todo_app/widget/date_time_field.dart';

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
    return CustomFormScaffold(
      title: Text(
          _formState.mode == TodoFormMode.edit ? 'Редактировать' : 'Добавить'),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(),
            _buildDescriptionField(),
            _buildNotificationDateTimeField(),
          ],
        ),
      ),
      saveFormCallback: _save,
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
        maxLines: 5,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.description_outlined, color: Colors.amber),
          hintText: 'Описание',
        ),
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
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.title_outlined, color: Colors.amber),
          hintText: 'Название',
        ),
        initialValue: _formState.title,
        onSaved: (value) => _formState.title = value,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Заполните это поле' : null,
      ),
    );
  }

  Future<bool> _save(BuildContext context) async {
    var validationResult = _formKey.currentState?.validate() ?? false;

    if (!validationResult) {
      return false;
    }

    _formKey.currentState?.save();
    await Provider.of<TodoList>(context, listen: false)
        .save(_formState.toModel());

    return true;
  }
}
