import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showPlatformDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  TargetPlatform? platform,
}) async {
  platform ??= Theme.of(context).platform;

  if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
    return await showCupertinoDialog(context: context, builder: builder);
  } else {
    return await showDialog(context: context, builder: builder);
  }
}

class PlatformAlertDialogAction extends StatelessWidget {
  final String title;
  final bool isDefaultAction, isDestructiveAction;
  final VoidCallback onPressed;
  final TargetPlatform? platform;
  final ButtonStyle? materialActionStyle;
  final ButtonStyle? materialDefaultActionStyle;
  final ButtonStyle? materialDestructiveActionStyle;

  const PlatformAlertDialogAction({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.platform,
    this.materialActionStyle,
    this.materialDefaultActionStyle,
    this.materialDestructiveActionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var effectivePlatform = platform ?? Theme.of(context).platform;

    if (effectivePlatform == TargetPlatform.iOS ||
        effectivePlatform == TargetPlatform.macOS) {
      return CupertinoDialogAction(
        child: Text(title),
        isDefaultAction: isDefaultAction,
        isDestructiveAction: isDestructiveAction,
        onPressed: onPressed,
      );
    } else {
      return TextButton(
        style: _getButtonStyle(context),
        child: Text(title.toUpperCase()),
        onPressed: onPressed,
      );
    }
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    if (isDestructiveAction) {
      return materialDestructiveActionStyle ?? materialActionStyle;
    }

    if (isDefaultAction) {
      return materialDefaultActionStyle ?? materialActionStyle;
    }

    return materialActionStyle;
  }
}

class PlatformAlertDialog extends StatelessWidget {
  final Widget title;
  final Widget? content;
  final List<Widget> actions;
  final TargetPlatform? platform;

  const PlatformAlertDialog({
    Key? key,
    required this.title,
    this.content,
    required this.actions,
    this.platform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var effectivePlatform = platform ?? Theme.of(context).platform;

    if (effectivePlatform == TargetPlatform.iOS ||
        effectivePlatform == TargetPlatform.macOS) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    } else {
      return AlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    }
  }
}
