import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: InkWell(
            child: Text(DateFormat.yMMMd().format(value)),
            onTap: () => _selectDate(context),
          ),
        ),
        Expanded(
          child: InkWell(
            child: Text(DateFormat.Hm().format(value)),
            onTap: () => _selectTime(context),
          ),
        ),
      ],
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
