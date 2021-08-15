import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/custom_selector/custom_selector.dart';

class CustomSelectorDialog<T> extends StatefulWidget {
  final String title;
  final T? value;
  final List<CustomSelectorItem<T>> items;

  const CustomSelectorDialog({
    Key? key,
    required this.items,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  _CustomSelectorDialogState<T> createState() =>
      _CustomSelectorDialogState<T>();
}

class _CustomSelectorDialogState<T> extends State<CustomSelectorDialog<T>> {
  T? _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(widget.title)),
      contentPadding: const EdgeInsets.all(16),
      content: _buildList(context),
      actions: [
        TextButton(
          child: Text('ВЫБРАТЬ'),
          onPressed: () => Navigator.pop(context, _value),
        ),
        TextButton(
          child: Text('ОТМЕНА'),
          onPressed: () => Navigator.pop(context, widget.value),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: widget.items.map((e) => _buildItem(context, e)).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, CustomSelectorItem<T> item) {
    return ListTile(
      trailing: _value == item.value ? Icon(Icons.check) : SizedBox(),
      title: item.child,
      onTap: () => setState(() => _value = item.value),
    );
  }
}
