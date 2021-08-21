import 'dart:ui';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/state/form/entity_form_state.dart';

class FolderFormState extends EntityFormState<Folder, int> {
  String? title;
  String? description;
  Color? color;

  FolderFormState({
    required FormMode mode,
    int? id,
    this.title,
    this.description,
    this.color,
  }) : super(mode, id);

  factory FolderFormState.fromModel(Folder folder) {
    return FolderFormState(
      mode: FormMode.edit,
      id: folder.id,
      title: folder.title,
      description: folder.description,
      color: Color(folder.color),
    );
  }

  factory FolderFormState.create() => FolderFormState(mode: FormMode.add);

  @override
  Folder toModel() {
    return Folder(
      id: id,
      title: title!,
      description: description!,
      color: color!.value,
    );
  }
}
