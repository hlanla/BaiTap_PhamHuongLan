import 'package:flutter/material.dart';

Widget chooseDateDialog({
  DateTime? initialDate,
  required Function(DateTime) onChanged,
}) {
  return AlertDialog(
    contentPadding: const EdgeInsets.all(0),
    content: SizedBox(
      height: 300,
      width: 300,
      child: CalendarDatePicker(
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        onDateChanged: onChanged,
      ),
    ),
  );
}
