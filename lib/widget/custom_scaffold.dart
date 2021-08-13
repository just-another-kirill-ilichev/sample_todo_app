import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget title, body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const CustomScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          actions: actions,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: title,
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: body,
        )
      ]),
      floatingActionButton: floatingActionButton,
    );
  }
}
