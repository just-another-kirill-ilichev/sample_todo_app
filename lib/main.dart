import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/domain/db_service.dart';
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
        ChangeNotifierProxyProvider<DbService, TodoList>(
          create: (ctx) => TodoList(Provider.of<DbService>(ctx, listen: false)),
          update: (ctx, service, __) => TodoList(service),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
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
