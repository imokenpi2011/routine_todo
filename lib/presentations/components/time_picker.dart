import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final String label;
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimePicker({
    super.key,
    required this.label,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      child: ListTile(
        title: Text(widget.label),
        trailing: Text(_selectedTime.format(context)),
        onTap: () async {
          final time = await showTimePicker(
            context: context,
            initialTime: _selectedTime,
          );
          if (time != null) {
            setState(() {
              _selectedTime = time;
            });
            widget.onTimeChanged(time);
          }
        },
      ),
    );
  }
}
