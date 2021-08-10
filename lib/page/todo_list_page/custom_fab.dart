import 'package:flutter/material.dart';

class CustomFab extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final double radius;
  final double size;

  const CustomFab({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.radius = 16,
    this.size = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius),
        splashColor: accent.withOpacity(0.1),
        highlightColor: accent.withOpacity(0.1),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: accent, width: 2),
            color: accent,
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.7),
                offset: Offset(0, 4),
                blurRadius: 12.0,
              )
            ],
          ),
          child: IconTheme(
            data: IconThemeData(color: Colors.white, size: 32),
            child: icon,
          ),
        ),
      ),
    );
  }
}
