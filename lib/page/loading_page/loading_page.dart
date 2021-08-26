import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final Color background;

  const LoadingPage({
    Key? key,
    this.background = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
