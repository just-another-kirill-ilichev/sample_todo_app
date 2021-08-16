import 'package:flutter/material.dart';
import 'package:sample_todo_app/widget/color_field/color_tile.dart';

class ColorPicker extends StatefulWidget {
  final Color? initialValue;
  final List<Color> palette;

  const ColorPicker({
    Key? key,
    required this.initialValue,
    this.palette = const [
      Color(0xffffbe0b),
      Color(0xfffb5607),
      Color(0xffff006e),
      Color(0xff8338ec),
      Color(0xff3a86ff),
    ],
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color? _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Выберите цвет'),
      content: Wrap(
        children: widget.palette.map((e) => _buildColorTile(e)).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _value),
          child: Text('ВЫБРАТЬ'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, widget.initialValue),
          child: Text('ОТМЕНА'),
        ),
      ],
    );
  }

  Widget _buildColorTile(Color color) {
    return ColorTile(
      value: color,
      selected: color == _value,
      onTap: () => setState(() => _value = color),
    );
  }
}
