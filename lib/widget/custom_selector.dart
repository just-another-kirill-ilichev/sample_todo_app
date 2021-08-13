import 'package:flutter/material.dart';

class CustomSelectorItem<T> {
  final T? value;
  final Widget child;

  CustomSelectorItem({required this.value, required this.child});
}

class CustomSelectorFormField<T> extends FormField<T> {
  CustomSelectorFormField({
    required FormFieldSetter<T> onSaved,
    required List<CustomSelectorItem<T>> items,
    FormFieldValidator<T>? validator,
    required T? initialValue,
    required String dialogTitle,
    InputDecoration? decoration,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<T> state) {
            return CustomSelector<T>(
              value: state.value,
              items: items,
              onChanged: state.didChange,
              decoration: decoration,
              dialogTitle: dialogTitle,
            );
          },
        );
}

class CustomSelector<T> extends StatelessWidget {
  final List<CustomSelectorItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final InputDecoration? decoration;
  final String dialogTitle;

  const CustomSelector({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.decoration,
    required this.dialogTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _select(context),
      child: InputDecorator(
        decoration: decoration ?? InputDecoration(),
        child: _findItemWithValue(value),
      ),
    );
  }

  Widget _findItemWithValue(T? value) {
    return items.where((e) => e.value == value).first.child;
  }

  Future<void> _select(BuildContext context) async {
    FocusScope.of(context).unfocus();

    var result = await showDialog<T>(
      context: context,
      builder: (ctx) => _CustomSelectorDialog<T>(
        items: items,
        title: dialogTitle,
      ),
    );

    onChanged(result);
  }
}

class _CustomSelectorDialog<T> extends StatelessWidget {
  final String title;
  final List<CustomSelectorItem<T>> items;

  const _CustomSelectorDialog({
    Key? key,
    required this.items,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(child: Text(title)),
      contentPadding: const EdgeInsets.all(16),
      children: items.map((e) => _buildItem(context, e)).toList(),
    );
  }

  Widget _buildItem(BuildContext context, CustomSelectorItem<T> item) {
    return SimpleDialogOption(
      padding: const EdgeInsets.all(16),
      child: item.child,
      onPressed: () => Navigator.pop(context, item.value),
    );
  }
}
