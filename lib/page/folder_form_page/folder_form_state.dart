import 'package:sample_todo_app/model/folder.dart';

class FolderFormState {
  String? title;
  String? description;
  int? color = 0xFFFF0000;

  Folder toModel() {
    return Folder(
      title: title!,
      description: description!,
      color: color!,
    );
  }
}
