import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? leading, trailing;
  final Widget title, subtitle;

  const CustomListTile({
    Key? key,
    this.onTap,
    this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
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
              Expanded(
                child: Column(
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
              ),
              if (trailing != null)
                DefaultTextStyle(
                  style: TextStyle(color: Colors.black45),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
