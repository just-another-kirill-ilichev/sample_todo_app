import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget title, subtitle, trailing;

  const CustomListTile({
    Key? key,
    this.onTap,
    this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        highlightColor: primary.withOpacity(0.2),
        splashColor: primary.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: primary.withOpacity(0.15),
          ),
          padding: EdgeInsets.fromLTRB(16, 16, 24, 16),
          child: Row(
            children: [
              if (leading != null)
                IconTheme(data: IconThemeData(color: primary), child: leading!),
              if (leading != null) SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    child: title,
                  ),
                  SizedBox(height: 2),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                    child: subtitle,
                  ),
                ],
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(color: Colors.black45),
                child: trailing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
