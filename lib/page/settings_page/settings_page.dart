import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/state/settings_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsChangeNotifier>(
      builder: (ctx, settings, _) => CustomScaffold(
        title: Text('Настройки'),
        body: SliverToBoxAdapter(
          child: Row(
            children: [
              Text(
                'Сохранять автоматически',
                style: Theme.of(context).accentTextTheme.subtitle2,
              ),
              Spacer(),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: settings.autosave,
                onChanged: (value) => settings.autosave = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
