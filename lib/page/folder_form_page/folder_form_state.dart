import 'package:sample_todo_app/model/folder.dart';

class FolderFormState {
  String? title;

  Folder toModel() {
    return Folder(title: title!);
  }
}
