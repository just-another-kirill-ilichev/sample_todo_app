import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/state/form/folder_form_state.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/state/form/entity_form_state.dart';
import 'package:sample_todo_app/widget/color_field/color_field.dart';
import 'package:sample_todo_app/widget/custom_form_scaffold.dart';
import 'package:sample_todo_app/widget/form_section/form_section.dart';

class FolderFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FolderFormState _formState;

  FolderFormPage._({Key? key, required FolderFormState data})
      : _formState = data,
        super(key: key);

  factory FolderFormPage.add() {
    return FolderFormPage._(data: FolderFormState.create());
  }

  factory FolderFormPage.edit(Folder folder) {
    return FolderFormPage._(data: FolderFormState.fromModel(folder));
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormScaffold(
      title: Text(
          _formState.mode == FormMode.add ? 'Добавить папку' : 'Редактировать'),
      body: Form(
        key: _formKey,
        child: Column(children: [
          FormSection(
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
          FormSection(
            title: Text('Цвет'),
            // TODO: Update FormField value when color set by picker
            // action: ClickableText(
            //   text: 'Выбрать',
            //   onTap: () async {
            //     _formState.color = await showDialog(
            //       context: context,
            //       builder: (_) => ColorPicker(
            //         initialValue: _formState.color,
            //       ),
            //     );
            //   },
            // ),
            field: ColorFormField(
              initialValue: _formState.color ?? Color(0xffffbe0b),
              palette: [
                Color(0xffffbe0b),
                Color(0xfffb5607),
                Color(0xffff006e),
                Color(0xff8338ec),
                Color(0xff3a86ff),
              ],
              onSaved: (value) => _formState.color = value,
            ),
          ),
          FormSection(
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
