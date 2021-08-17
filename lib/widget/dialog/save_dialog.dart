import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/dialog/platform_dialog.dart';

enum SaveDialogResult {
  save,
  discard,
  cancel,
}

class SaveDialog extends StatelessWidget {
  final String title;

  const SaveDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: Text(title),
      actions:
          SaveDialogResult.values.map((e) => _buildAction(context, e)).toList(),
    );
  }

  Widget _buildAction(BuildContext context, SaveDialogResult result) {
    return PlatformAlertDialogAction(
      title: _getText(result),
      isDestructiveAction: result == SaveDialogResult.discard,
      onPressed: () => Navigator.pop(context, result),
    );
  }

  String _getText(SaveDialogResult result) {
    switch (result) {
      case SaveDialogResult.save:
        return 'Сохранить';
      case SaveDialogResult.discard:
        return 'Не сохранять';
      case SaveDialogResult.cancel:
        return 'Отмена';
    }
  }
}
