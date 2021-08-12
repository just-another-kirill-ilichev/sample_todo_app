import 'package:flutter/material.dart';

class CustomFormSection extends StatelessWidget {
  final Widget title, field;

  const CustomFormSection({
    Key? key,
    required this.title,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 12),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            child: title,
          ),
        ),
        field,
      ],
    );
  }
}
