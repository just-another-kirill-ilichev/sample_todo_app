import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final int initialValue;
  final List<int> palette;

  const ColorPicker({
    Key? key,
    required this.initialValue,
    this.palette = const [
      0xffffbe0b,
      0xfffb5607,
      0xffff006e,
      0xff8338ec,
      0xff3a86ff,
    ],
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late int _value;

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

  Widget _buildColorTile(int color) {
    return InkWell(
      onTap: () => setState(() => _value = color),
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: _value == color
              ? Border.all(color: Color(color), width: 2)
              : Border.all(color: Colors.transparent),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Color(color),
          ),
        ),
      ),
    );
  }
}
