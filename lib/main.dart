import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/domain/service/db_service.dart';
import 'package:sample_todo_app/domain/service/log_service.dart';
import 'package:sample_todo_app/domain/service/preferences_service.dart';
import 'package:sample_todo_app/page/loading_page/loading_page.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/state/settings_change_notifier.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ServicesInitializer(
      loadingBuilder: (_) => LoadingPage(),
      errorBuilder: (_) => LoadingPage(),
      builder: (_) => MultiProvider(
        providers: [
          ChangeNotifierProxyProvider<DbService, FoldersChangeNotifier>(
            create: (ctx) => FoldersChangeNotifier(
                Provider.of<DbService>(ctx, listen: false).folderRepository),
            update: (ctx, service, __) =>
                FoldersChangeNotifier(service.folderRepository),
          ),
          ChangeNotifierProxyProvider<DbService, TodoChangeNotifier>(
            create: (ctx) => TodoChangeNotifier(
                Provider.of<DbService>(ctx, listen: false).todoRepository),
            update: (ctx, service, __) =>
                TodoChangeNotifier(service.todoRepository),
          ),
          ChangeNotifierProxyProvider<PreferencesService,
              SettingsChangeNotifier>(
            create: (ctx) => SettingsChangeNotifier(
                Provider.of<PreferencesService>(ctx, listen: false)
                    .preferences),
            update: (ctx, service, __) =>
                SettingsChangeNotifier(service.preferences),
          ),
        ],
        child: SettingsWrapper(
          loadingBuilder: (_) => LoadingPage(),
          builder: (_, theme) {
            return MaterialApp(
              title: 'TODO',
              theme: theme,
              initialRoute: AppRoute.folder_list,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}

class ServicesInitializer extends StatelessWidget {
  final LogService _logService = LogService();
  final DbService _dbService = DbService();
  final PreferencesService _prefsService = PreferencesService();

  final WidgetBuilder builder, loadingBuilder, errorBuilder;

  ServicesInitializer({
    Key? key,
    required this.builder,
    required this.loadingBuilder,
    required this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.wait([
        _logService,
        _dbService,
        _prefsService,
      ].map((e) => e.initialize())),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return loadingBuilder(ctx);
        }

        if (snapshot.hasError) {
          return errorBuilder(ctx);
        }

        return MultiProvider(
          providers: [
            Provider<LogService>.value(value: _logService),
            Provider<DbService>.value(value: _dbService),
            Provider<PreferencesService>.value(value: _prefsService),
          ],
          child: builder(context),
        );
      },
    );
  }
}

typedef Widget ThemedWidgetBuilder(BuildContext context, ThemeData theme);

class SettingsWrapper extends StatelessWidget {
  final ThemedWidgetBuilder builder;
  final WidgetBuilder loadingBuilder;

  const SettingsWrapper({
    Key? key,
    required this.builder,
    required this.loadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<SettingsChangeNotifier>(context).locale;

    return FutureBuilder(
      future: initializeDateFormatting(locale),
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done
          ? _buildThemeWrapper(context)
          : loadingBuilder(context),
    );
  }

  Widget _buildThemeWrapper(BuildContext context) {
    var settings = Provider.of<SettingsChangeNotifier>(context);

    var inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(16),
    );

    var primary = Colors.amber;

    var theme = ThemeData(
      primarySwatch: primary,
      highlightColor: primary.withOpacity(0.1),
      splashColor: primary.withOpacity(0.1),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: ThemeData.light().canvasColor,
      ),
      textTheme: GoogleFonts.ralewayTextTheme().copyWith(
        bodyText2: GoogleFonts.raleway(color: Colors.black45),
      ),
      primaryTextTheme: GoogleFonts.ralewayTextTheme(),
      accentTextTheme: GoogleFonts.ralewayTextTheme().copyWith(
        subtitle1: GoogleFonts.raleway(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        subtitle2: GoogleFonts.raleway(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        filled: true,
        fillColor: primary.withOpacity(0.15),
        contentPadding: const EdgeInsets.all(16),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1.25,
            color: primary,
          ),
        ),
      ),
    );

    return builder(context, theme);
  }
}
