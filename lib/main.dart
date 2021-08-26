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

import 'config/app_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ServicesInitializer(
      loadingBuilder: (_) => _buildSplashScreen(),
      errorBuilder: (_) => _buildSplashScreen(),
      builder: (_) => FutureBuilder(
        future: Future.wait([
          initializeDateFormatting(AppSettings.locale),
        ]),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? _buildApp(ctx)
                : _buildSplashScreen(),
      ),
    );
  }

  Widget _buildApp(BuildContext context) {
    return MultiProvider(
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
        ChangeNotifierProxyProvider<PreferencesService, SettingsChangeNotifier>(
          create: (ctx) => SettingsChangeNotifier(
              Provider.of<PreferencesService>(ctx, listen: false).preferences),
          update: (ctx, service, __) =>
              SettingsChangeNotifier(service.preferences),
        ),
      ],
      child: MaterialApp(
        title: 'TODO',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          highlightColor: Colors.amber.withOpacity(0.1),
          splashColor: Colors.amber.withOpacity(0.1),
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
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            filled: true,
            fillColor: Colors.amber.withOpacity(0.15),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
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
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
        initialRoute: AppRoute.folder_list,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }

  Widget _buildSplashScreen() {
    return MaterialApp(
      home: LoadingPage(),
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
