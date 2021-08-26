import 'package:intl/intl.dart';

@deprecated
class AppSettings {
  static const locale = 'ru_RU';

  static DateFormat dateTimeFormat = DateFormat('hh:mm d MMMM yyyy', locale);
  static DateFormat dateFormat = DateFormat.yMMMd(locale);
  static DateFormat timeFormat = DateFormat.Hm(locale);
}
