import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/page/folder_form_page/folder_form_state.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/widget/color_field/color_field.dart';
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
