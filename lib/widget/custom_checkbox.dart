import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double radius;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(radius),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: accent, width: 2),
          color: value ? accent : Colors.transparent,
        ),
        duration: const Duration(milliseconds: 200),
        child: Icon(
          Icons.check,
          size: 18,
          color: value ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }
}
