import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/page/loading_page/loading_page.dart';
import 'package:sample_todo_app/state/todo_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  final DbConnection _dbConnection = DbConnection();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _dbConnection.initializeDb(),
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
          primarySwatch: Colors.blue,
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
