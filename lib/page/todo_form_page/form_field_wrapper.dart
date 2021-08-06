import 'package:flutter/material.dart';

class FormFieldWrapper extends StatelessWidget {
  final Widget title;
  final Widget field;

  const FormFieldWrapper({
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
