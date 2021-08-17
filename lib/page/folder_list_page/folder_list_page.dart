import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/page/folder_list_page/folder_tile.dart';
import 'package:sample_todo_app/widget/custom_fab.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FolderListPage extends StatelessWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoldersChangeNotifier>(
      builder: (ctx, folders, ___) => CustomScaffold(
        title: Text('Списки'),
        body: MultiSliver(children: [
          SliverToBoxAdapter(child: _buildAll(context)),
          SliverToBoxAdapter(child: _buildToday(context)),
          SliverToBoxAdapter(child: Divider()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, idx) => _buildFolder(ctx, folders.items[idx]),
              childCount: folders.items.length,
            ),
          ),
        ]),
        floatingActionButton: CustomFab(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, AppRoute.add_folder),
        ),
      ),
    );
  }

  Widget _buildAll(BuildContext context) {
    return FolderTile(
      icon: Icon(Icons.list_outlined),
      title: Text('Все'),
      description: Text('Все задачи'),
      filter: TodoFilter(),
      count: 1,
    );
  }

  Widget _buildToday(BuildContext context) {
    return FolderTile(
      icon: Icon(Icons.calendar_today_outlined),
      title: Text('Сегодня'),
      description: Text('Задачи на сегодня'),
      filter: TodoFilter(date: DateTime.now()),
      count: 1,
    );
  }

  Widget _buildFolder(BuildContext context, Folder folder) {
    return FolderTile(
      icon: Icon(Icons.folder_outlined, color: Color(folder.color)),
      title: Text(folder.title),
      description: Text(folder.description),
      filter: TodoFilter(folderId: folder.id),
      count: 1,
    );
  }
}
