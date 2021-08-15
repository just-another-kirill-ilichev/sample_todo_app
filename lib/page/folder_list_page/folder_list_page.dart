import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/page/folder_list_page/folder_tile.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';

class FolderListPage extends StatelessWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoldersChangeNotifier>(
      builder: (ctx, folders, ___) => CustomScaffold(
        title: Text('Списки'),
        body: SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, idx) {
              if (idx == 0) return _buildAll(context);
              if (idx == 1) return _buildToday(context);
              if (idx == folders.items.length + 2)
                return _buildAddButton(context);
              return _buildFolder(context, folders.items[idx - 2]);
            },
            childCount: folders.items.length + 3,
          ),
        ),
      ),
    );
  }

  Widget _buildAll(BuildContext context) {
    return FolderTile(
      icon: Icon(Icons.list_outlined),
      title: Text('Все'),
      filter: TodoFilter(),
      count: 1,
    );
  }

  Widget _buildToday(BuildContext context) {
    return FolderTile(
      icon: Icon(Icons.calendar_today_outlined),
      title: Text('Сегодня'),
      filter: TodoFilter(date: DateTime.now()),
      count: 1,
    );
  }

  Widget _buildFolder(BuildContext context, Folder folder) {
    return FolderTile(
      icon: Icon(Icons.folder_outlined, color: Colors.green),
      title: Text(folder.title),
      filter: TodoFilter(folderId: folder.id),
      count: 1,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, AppRoute.add_folder),
        icon: Icon(Icons.add),
        label: Text('Добавить папку'),
      ),
    );
  }
}
