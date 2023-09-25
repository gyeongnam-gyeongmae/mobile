import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController{
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  void updateDate(DateTime? date){
    selectedDate.value = date;
  }

  void updateTime(TimeOfDay? date){
    selectedTime.value = date;  
  }

  DateTime getDate(){
    DateTime result = DateTime(selectedDate.value!.year, selectedDate.value!.month, selectedDate.value!.day);
    return result.add(Duration(hours: selectedTime.value!.hour, minutes: selectedTime.value!.minute));
  }
}