import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const ClickableText({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    );
  }
}
