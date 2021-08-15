import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SaveDialogResult {
  save,
  discard,
  cancel,
}

Future<SaveDialogResult> showPlatformSaveDialog(
    BuildContext context, WidgetBuilder builder) async {
  var platform = Theme.of(context).platform;

  if (platform == TargetPlatform.iOS) {
    return await showCupertinoDialog(context: context, builder: builder);
  } else {
    return await showDialog(
      context: context,
      builder: builder,
      barrierDismissible: false,
    );
  }
}

class SaveDialog extends StatelessWidget {
  final String title;

  const SaveDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        actions: SaveDialogResult.values
            .map((e) => _buildCupertinoAction(context, e))
            .toList(),
      );
    } else {
      return AlertDialog(
        title: Text(title),
        buttonPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        actions: SaveDialogResult.values
            .map((e) => _buildMaterialAction(context, e))
            .toList(),
      );
    }
  }

  Widget _buildCupertinoAction(BuildContext context, SaveDialogResult result) {
    return CupertinoDialogAction(
      child: Text(_getText(result)),
      isDestructiveAction: result == SaveDialogResult.discard,
      onPressed: () => Navigator.pop(context, result),
    );
  }

  Widget _buildMaterialAction(BuildContext context, SaveDialogResult result) {
    var textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 1.25,
      color: Theme.of(context).accentColor,
    );

    return TextButton(
      child: Text(_getText(result).toUpperCase(), style: textStyle),
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
