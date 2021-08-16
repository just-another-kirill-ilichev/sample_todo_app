import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/color_field/color_tile.dart';

class ColorFormField extends FormField<Color> {
  ColorFormField({
    required FormFieldSetter<Color> onSaved,
    required List<Color> palette,
    required Color? initialValue,
    InputDecoration? decoration,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          builder: (FormFieldState<Color> state) {
            return ColorField(
              value: state.value,
              palette: palette,
              onChanged: state.didChange,
            );
          },
        );
}

class ColorField extends StatelessWidget {
  final Color? value;
  final List<Color> palette;
  final ValueChanged<Color> onChanged;

  const ColorField({
    Key? key,
    required this.value,
    required this.palette,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = palette;

    if (!palette.contains(value) && value != null) {
      colors.insert(0, value!);
    }

    return Row(
      children: colors.map((e) => _buildItem(e)).toList(),
    );
  }

  Widget _buildItem(Color e) {
    return ColorTile(
      value: e,
      selected: e == value,
      onTap: () => onChanged(e),
      size: 32,
    );
  }
}
