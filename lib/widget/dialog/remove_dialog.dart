import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/dialog/platform_dialog.dart';

class RemoveDialog extends StatelessWidget {
  const RemoveDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: Text('Удалить'),
      content: Text('Это действие нельзя отменить'),
      actions: [
        PlatformAlertDialogAction(
          title: 'Ок',
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context, true),
        ),
        PlatformAlertDialogAction(
          title: 'Отмена',
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
