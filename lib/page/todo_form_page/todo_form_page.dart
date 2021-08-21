import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/form/todo_form_state.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/state/form/entity_form_state.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';
import 'package:sample_todo_app/widget/form_section/form_section_action.dart';
import 'package:sample_todo_app/widget/custom_form_scaffold.dart';
import 'package:sample_todo_app/widget/form_section/form_section.dart';
import 'package:sample_todo_app/widget/custom_selector/custom_selector.dart';
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
      title:
          Text(_formState.mode == FormMode.edit ? 'Редактировать' : 'Добавить'),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(),
            _buildDescriptionField(),
            _buildFolder(context),
            _buildNotificationDateTimeField(),
          ],
        ),
      ),
      saveFormCallback: _save,
    );
  }

  Widget _buildFolder(BuildContext context) {
    return FormSection(
      title: Text('Папка'),
      action: FormSectionAction(
        text: 'Добавить',
        onTap: () => Navigator.pushNamed(context, AppRoute.add_folder),
      ),
      field: CustomSelectorFormField<int>(
        title: 'Выберите папку',
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.folder_outlined, color: Colors.amber),
        ),
        initialValue: _formState.folderId,
        items: Provider.of<FoldersChangeNotifier>(context)
            .items
            .map((e) => CustomSelectorItem(child: Text(e.title), value: e.id))
            .toList()
              ..add(CustomSelectorItem(child: Text('Не указано'), value: null)),
        onSaved: (value) => _formState.folderId = value,
      ),
    );
  }

  Widget _buildNotificationDateTimeField() {
    return FormSection(
      title: Text('Дата завершения'),
      field: DateTimeFormField(
        onSaved: (value) => _formState.notificationDateTime = value,
        initialValue: _formState.notificationDateTime ?? DateTime.now(),
        validator: (value) => value == null ? 'Заполните это поле' : null,
      ),
    );
  }

  Widget _buildDescriptionField() {
    return FormSection(
      title: Text('Описание'),
      field: TextFormField(
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
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
    return FormSection(
      title: Text('Название'),
      field: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
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
    await Provider.of<TodoChangeNotifier>(context, listen: false)
        .save(_formState.toModel());

    return true;
  }
}
