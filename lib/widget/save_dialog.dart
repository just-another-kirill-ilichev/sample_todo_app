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
    return await showDialog(context: context, builder: builder);
  }
}

class SaveDialog extends StatelessWidget {
  final String title, description;

  const SaveDialog({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: SaveDialogResult.values
            .map((e) => _buildCupertinoAction(context, e))
            .toList(),
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
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
    return TextButton(
      child: Text(
        _getText(result),
        style: TextStyle(
          color: result == SaveDialogResult.discard ? Colors.red : Colors.blue,
        ),
      ),
      onPressed: () => Navigator.pop(context, result),
    );
  }

  String _getText(SaveDialogResult result) {
    switch (result) {
      case SaveDialogResult.save:
        return 'Save';
      case SaveDialogResult.discard:
        return 'Discard';
      case SaveDialogResult.cancel:
        return 'Cancel';
    }
  }
}
