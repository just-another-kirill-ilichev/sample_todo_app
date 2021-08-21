import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/domain/db_service.dart';
import 'package:sample_todo_app/domain/log_service.dart';
import 'package:sample_todo_app/page/loading_page/loading_page.dart';
import 'package:sample_todo_app/state/folders_change_notifier.dart';
import 'package:sample_todo_app/state/settings_change_notifier.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';

import 'config/app_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LogService.instance().initialize();

  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _dbService.initialize(),
        initializeDateFormatting(AppSettings.locale),
      ]),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? _buildApp(context)
              : _buildSplashScreen(),
    );
  }

  Widget _buildApp(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _dbService),
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
        ChangeNotifierProvider<SettingsChangeNotifier>(
          create: (_) => SettingsChangeNotifier(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
