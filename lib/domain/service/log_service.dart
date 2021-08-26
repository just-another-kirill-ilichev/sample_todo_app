import 'package:logging/logging.dart';
import 'package:sample_todo_app/domain/service/service.dart';

class LogService implements Service {
  Future<void> initialize() async {
    Logger.root.level = Level.ALL;
    // TODO
    Logger.root.onRecord.listen((record) {
      print(
          '[${record.level.name}] ${record.loggerName}: ${record.time}: ${record.message}');
    });
  }
}
