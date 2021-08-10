import 'package:flutter/material.dart';
import 'package:sample_todo_app/config/app_settings.dart';

class DateTimeFormField extends FormField<DateTime> {
  DateTimeFormField({
    required FormFieldSetter<DateTime> onSaved,
    FormFieldValidator<DateTime>? validator,
    required DateTime initialValue,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<DateTime> state) {
            return DateTimeField(
              value: state.value ?? initialValue,
              onChanged: state.didChange,
            );
          },
        );
}

class DateTimeField extends StatelessWidget {
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  const DateTimeField({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(contentPadding: const EdgeInsets.all(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Selector(
            icon: Icon(Icons.calendar_today_outlined),
            child: Text(AppSettings.dateFormat.format(value)),
            onTap: () => _selectDate(context),
          ),
          Divider(color: Colors.grey),
          _Selector(
            icon: Icon(Icons.watch_later_outlined),
            child: Text(AppSettings.timeFormat.format(value)),
            onTap: () => _selectTime(context),
          ),
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (date != null) {
      _update(date: date);
    }
  }

  void _selectTime(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 0),
    );

    if (time != null) {
      _update(time: time);
    }
  }

  void _update({TimeOfDay? time, DateTime? date}) {
    var newValue = DateTime(
      date?.year ?? value.year,
      date?.month ?? value.month,
      date?.day ?? value.day,
      time?.hour ?? value.hour,
      time?.minute ?? value.minute,
    );

    onChanged(newValue);
  }
}

class _Selector extends StatelessWidget {
  final Widget icon;
  final Widget child;
  final VoidCallback onTap;

  const _Selector({
    Key? key,
    required this.icon,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).accentColor;

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
            child: IconTheme(
              data: IconThemeData(color: primary),
              child: icon,
            ),
          ),
          child,
        ],
      ),
      onTap: onTap,
    );
  }
}
