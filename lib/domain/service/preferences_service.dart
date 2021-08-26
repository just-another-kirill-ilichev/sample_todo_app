import 'package:logging/logging.dart';
import 'package:sample_todo_app/domain/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService implements Service {
  static final Logger _logger = Logger('PreferencesService');

  late SharedPreferences _preferences;

  SharedPreferences get preferences => _preferences;

  Future<void> initialize() async {
    _logger.fine('Fetching app preferences');
    _preferences = await SharedPreferences.getInstance();
  }
}
