import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final Color value;
  final bool selected;
  final VoidCallback onTap;
  final double size;
  final EdgeInsets margin;

  const ColorTile({
    Key? key,
    required this.value,
    required this.selected,
    required this.onTap,
    this.size = 48,
    this.margin = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: margin,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: selected
              ? Border.all(color: value, width: 2)
              : Border.all(color: Colors.transparent),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: value,
          ),
        ),
      ),
    );
  }
}
