import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/page/folder_list_page/folder_tile.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';

class FolderListPage extends StatelessWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoldersChangeNotifier>(
      builder: (ctx, folders, ___) => CustomScaffold(
        title: Text('Списки'),
        body: SliverList(
          delegate: SliverChildListDelegate(
            [
              FolderTile(
                icon: Icon(Icons.list_outlined),
                title: Text('Все'),
                onTap: () => Navigator.pushNamed(context, AppRoute.todo_list),
                count: 10,
              ),
              FolderTile(
                icon: Icon(Icons.calendar_today_outlined),
                title: Text('Сегодня'),
                onTap: () => Navigator.pushNamed(context, AppRoute.todo_list),
                count: 2,
              ),
              FolderTile(
                icon: Icon(Icons.folder_outlined, color: Colors.cyan),
                title: Text('Папка 1'),
                onTap: () => Navigator.pushNamed(context, AppRoute.todo_list),
                count: 4,
              ),
              FolderTile(
                icon: Icon(Icons.folder_outlined, color: Colors.green),
                title: Text('Папка 2'),
                onTap: () => Navigator.pushNamed(context, AppRoute.todo_list),
                count: 1,
              ),
              FolderTile(
                icon: Icon(Icons.folder_outlined, color: Colors.purple),
                title: Text('Папка 3'),
                onTap: () => Navigator.pushNamed(context, AppRoute.todo_list),
                count: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoute.add_folder),
                  icon: Icon(Icons.add),
                  label: Text('Добавить папку'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
