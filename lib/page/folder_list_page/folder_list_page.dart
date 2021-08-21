import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/meta_folder.dart';
import 'package:sample_todo_app/page/folder_list_page/folder_tile.dart';
import 'package:sample_todo_app/widget/custom_fab.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FolderListPage extends StatelessWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoldersChangeNotifier>(
      builder: (ctx, folders, ___) => CustomScaffold(
        title: Text('Списки'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, AppRoute.settings),
          ),
        ],
        body: MultiSliver(children: [
          SliverToBoxAdapter(
            child: FolderTile(
              metaFolder: MetaFolder(type: MetaFolderType.all),
            ),
          ),
          SliverToBoxAdapter(
            child: FolderTile(
              metaFolder: MetaFolder(type: MetaFolderType.today),
            ),
          ),
          SliverToBoxAdapter(child: Divider()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, idx) => FolderTile(
                metaFolder: MetaFolder(
                  type: MetaFolderType.folder,
                  folder: folders.items[idx],
                ),
              ),
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
}
