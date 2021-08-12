import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/custom_form_scaffold.dart';

class FolderFormPage extends StatelessWidget {
  const FolderFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormScaffold(
      title: Text('Добавить папку'),
      body: Form(
        child: Column(children: [
          TextFormField(),
        ]),
      ),
      saveFormCallback: (_) async => true,
    );
  }
}
