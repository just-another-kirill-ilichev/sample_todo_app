import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/custom_selector/custom_selector_action_sheet.dart';
import 'package:sample_todo_app/widget/custom_selector/custom_selector_dialog.dart';

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
    required String title,
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
              title: title,
            );
          },
        );
}

class CustomSelector<T> extends StatelessWidget {
  final String title;
  final List<CustomSelectorItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final InputDecoration? decoration;

  const CustomSelector({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.decoration,
    required this.title,
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

    var platform = Theme.of(context).platform;
    T? result;

    if (platform == TargetPlatform.iOS) {
      result = await showCupertinoModalPopup(
        context: context,
        builder: (_) => CustomSelectorActionSheet<T>(
          title: title,
          items: items,
          value: value,
        ),
      );
    } else {
      result = await showDialog<T>(
        context: context,
        builder: (_) => CustomSelectorDialog(
          title: title,
          items: items,
          value: value,
        ),
      );
    }

    onChanged(result);
  }
}
