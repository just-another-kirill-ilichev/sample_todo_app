import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/config/app_schema.dart';
import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/domain/log_service.dart';
import 'package:sample_todo_app/page/loading_page/loading_page.dart';
import 'package:sample_todo_app/state/todo_list.dart';

import 'config/app_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LogService.instance().initialize();

  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  final DbConnection _dbConnection = DbConnection([
    AppSchema.todos,
    AppSchema.folders,
  ]);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _dbConnection.initializeDb(),
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
        Provider.value(value: _dbConnection),
        ChangeNotifierProxyProvider<DbConnection, TodoList>(
          create: (ctx) =>
              TodoList(Provider.of<DbConnection>(ctx, listen: false)),
          update: (ctx, connection, __) => TodoList(connection),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
          ),
        ),
        initialRoute: AppRoute.todo_list,
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
