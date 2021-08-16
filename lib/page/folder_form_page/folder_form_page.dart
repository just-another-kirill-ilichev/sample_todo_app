import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/page/folder_form_page/folder_form_state.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_color_picker.dart';
import 'package:sample_todo_app/widget/custom_form_scaffold.dart';
import 'package:sample_todo_app/widget/custom_form_section.dart';

class FolderFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formState = FolderFormState();

  FolderFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormScaffold(
      title: Text('Добавить папку'),
      body: Form(
        key: _formKey,
        child: Column(children: [
          CustomFormSection(
            title: Text('Название'),
            field: TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              initialValue: _formState.title,
              onSaved: (value) => _formState.title = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Заполните это поле' : null,
            ),
          ),
          CustomFormSection(
            title: Text('Описание'),
            field: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              initialValue: _formState.description,
              onSaved: (value) => _formState.description = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Заполните это поле' : null,
            ),
          ),
          IconButton(
            onPressed: () async {
              _formState.color = await showDialog(
                context: context,
                builder: (_) => CustomColorPicker(
                  initialValue: _formState.color!,
                ),
              );
            },
            icon: Icon(Icons.colorize),
          )
        ]),
      ),
      saveFormCallback: (_) async => await _save(context),
    );
  }

  Future<bool> _save(BuildContext context) async {
    var validationResult = _formKey.currentState?.validate() ?? false;

    if (!validationResult) {
      return false;
    }

    _formKey.currentState?.save();
    await Provider.of<FoldersChangeNotifier>(context, listen: false)
        .save(_formState.toModel());

    return true;
  }
}
