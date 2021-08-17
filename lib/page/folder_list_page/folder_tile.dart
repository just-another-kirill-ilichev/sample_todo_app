import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/meta_folder.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_list_tile.dart';

class FolderTile extends StatelessWidget {
  final MetaFolder metaFolder;

  const FolderTile({
    Key? key,
    required this.metaFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;
    Widget title, description, icon;

    switch (metaFolder.type) {
      case MetaFolderType.folder:
        title = Text(metaFolder.folder!.title);
        description = Text(metaFolder.folder!.description);
        icon = Icon(
          Icons.folder_outlined,
          color: Color(metaFolder.folder!.color),
        );
        break;
      case MetaFolderType.all:
        title = Text('Все');
        description = Text('Все задачи');
        icon = Icon(Icons.list_outlined, color: accent);
        break;
      case MetaFolderType.today:
        title = Text('Сегодня');
        description = Text('Задачи на сегодня');
        icon = Icon(Icons.calendar_today_outlined, color: accent);
        break;
    }

    var widget = CustomListTile(
      title: title,
      leading: icon,
      subtitle: description,
      trailing: Text(1.toString()),
      onTap: () => _onTap(context),
    );

    if (metaFolder.type == MetaFolderType.folder) {
      return Dismissible(
        key: ValueKey(metaFolder.folder!.id),
        child: widget,
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 24),
          child: Icon(Icons.delete, color: accent, size: 32),
        ),
        onDismissed: (direction) => _remove(context),
      );
    }

    return widget;
  }

  Future<void> _remove(BuildContext context) async {
    await Provider.of<FoldersChangeNotifier>(context, listen: false)
        .remove(metaFolder.folder!);
  }

  Future<void> _onTap(BuildContext context) async {
    var notifier = Provider.of<TodoChangeNotifier>(context, listen: false);
    notifier.currentFolder = metaFolder;
    await Navigator.pushNamed(context, AppRoute.todo_list);
  }
}
