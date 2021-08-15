import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';
import 'package:sample_todo_app/widget/save_dialog.dart';

typedef Future<bool> SaveFormCallback(BuildContext context);

class CustomFormScaffold extends StatelessWidget {
  final Widget title, body;
  final SaveFormCallback saveFormCallback;
  final bool showDialog;
  final String dialogTitle;

  const CustomFormScaffold({
    Key? key,
    required this.title,
    required this.body,
    required this.saveFormCallback,
    this.showDialog = true,
    this.dialogTitle = 'Сохранить изменения?',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _save(context),
      child: CustomScaffold(
        title: title,
        body: SliverToBoxAdapter(child: body),
        actions: [
          IconButton(
            onPressed: () async {
              if (await saveFormCallback(context)) Navigator.pop(context);
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
    );
  }

  Future<bool> _save(BuildContext context) async {
    if (!showDialog) {
      return await saveFormCallback(context);
    }

    SaveDialogResult result = await showPlatformSaveDialog(
      context,
      (_) => SaveDialog(title: dialogTitle),
    );

    switch (result) {
      case SaveDialogResult.save:
        return await saveFormCallback(context);
      case SaveDialogResult.discard:
        return true;
      case SaveDialogResult.cancel:
        return false;
    }
  }
}
