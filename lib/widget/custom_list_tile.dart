import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? leading, trailing;
  final Widget title, subtitle;
  final EdgeInsets margin;

  const CustomListTile({
    Key? key,
    this.onTap,
    this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accentColor = Theme.of(context).accentColor;
    var textTheme = Theme.of(context).textTheme;
    var accentTextTheme = Theme.of(context).accentTextTheme;

    return Padding(
      padding: margin,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: accentColor.withOpacity(0.15),
          ),
          padding: EdgeInsets.fromLTRB(16, 16, 24, 16),
          child: Row(
            children: [
              if (leading != null)
                IconTheme(
                    data: IconThemeData(color: accentColor), child: leading!),
              if (leading != null) SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: accentTextTheme.subtitle1!,
                      child: title,
                    ),
                    SizedBox(height: 2),
                    DefaultTextStyle(
                      style: textTheme.bodyText2!,
                      child: subtitle,
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                DefaultTextStyle(
                  style: textTheme.bodyText2!,
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
