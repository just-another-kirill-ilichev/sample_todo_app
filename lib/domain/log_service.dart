import 'package:logging/logging.dart';

class LogService {
  static LogService _instance = LogService._();

  LogService._();

  factory LogService.instance() => _instance;

  void initialize() {
    Logger.root.level = Level.ALL;
    // TODO
    Logger.root.onRecord.listen((record) {
      print(
          '[${record.level.name}] ${record.loggerName}: ${record.time}: ${record.message}');
    });
  }
}
