import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  final Widget title, field;
  final Widget? action;

  const FormSection({
    Key? key,
    required this.title,
    required this.field,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 12),
          child: Row(
            children: [
              DefaultTextStyle(
                style: Theme.of(context).accentTextTheme.subtitle2!,
                child: title,
              ),
              Spacer(),
              if (action != null) action!,
            ],
          ),
        ),
        field,
      ],
    );
  }
}
