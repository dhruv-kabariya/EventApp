

import 'package:flutter/material.dart';

Future<DateTime> selectDate({context,DateTime startTime,DateTime endTime}) async {
  DateTime selectedDate = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: startTime, 
    lastDate: endTime);
  
  return selectedDate;
}

Future<TimeOfDay> timeSelect({BuildContext context,TimeOfDay startTime}) async {
  TimeOfDay time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
  return time;
}