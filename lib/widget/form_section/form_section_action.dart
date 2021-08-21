import 'package:flutter/material.dart';

class FormSectionAction extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const FormSectionAction({
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
        style: Theme.of(context)
            .accentTextTheme
            .bodyText2!
            .copyWith(color: Theme.of(context).accentColor),
      ),
    );
  }
}
