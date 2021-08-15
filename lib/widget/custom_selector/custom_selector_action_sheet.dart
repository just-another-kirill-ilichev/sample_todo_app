import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/custom_selector/custom_selector.dart';

class CustomSelectorActionSheet<T> extends StatelessWidget {
  final String title;
  final T? value;
  final List<CustomSelectorItem<T>> items;

  const CustomSelectorActionSheet({
    Key? key,
    required this.title,
    required this.items,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(title),
      actions: items.map((e) => _buildItem(context, e)).toList(),
      cancelButton: CupertinoActionSheetAction(
        child: Text('Отмена'),
        onPressed: () => Navigator.pop(context, value),
      ),
    );
  }

  Widget _buildItem(BuildContext context, CustomSelectorItem<T> item) {
    return CupertinoActionSheetAction(
      onPressed: () => Navigator.pop(context, item.value),
      child: item.child,
    );
  }
}
