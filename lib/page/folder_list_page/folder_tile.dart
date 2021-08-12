import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/custom_list_tile.dart';

class FolderTile extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon, title;
  final int count;

  const FolderTile({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;

    return CustomListTile(
      title: title,
      leading: IconTheme(data: IconThemeData(color: primary), child: icon),
      subtitle: Text('Fdsfkskfghrkjgjrvgbrkjbgkjere'),
      trailing: Text(count.toString()),
      onTap: onTap,
    );
  }
}
