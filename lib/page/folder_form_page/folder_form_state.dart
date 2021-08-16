import 'dart:ui';
import 'package:sample_todo_app/model/folder.dart';

class FolderFormState {
  String? title;
  String? description;
  Color? color;

  Folder toModel() {
    return Folder(
      title: title!,
      description: description!,
      color: color!.value,
    );
  }
}
