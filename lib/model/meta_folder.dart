import 'package:sample_todo_app/model/folder.dart';

enum MetaFolderType { folder, all, today }

class MetaFolder {
  final MetaFolderType type;
  final Folder? folder;

  MetaFolder({required this.type, this.folder});
}
