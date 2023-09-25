import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/date_picker_controller.dart';


class CustomTimepicker extends GetView<DatePickerController> {
  String? _selectedTime = "end time";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showTime(context);
            },
            child: Obx(() {
              return Text(
                controller.selectedTime.value != null
                    ? controller.selectedTime.value!.format(context)
                    : "end time",
                style: const TextStyle(fontSize: 25));
            })
          ),
          IconButton(
            icon: const Icon(
              Icons.alarm,
              size: 30,
            ),
            onPressed: () {
              showTime(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> showTime(BuildContext con) async {
    final date = await showTimePicker(
      context: con,
      initialTime: TimeOfDay.now()
      );
    print(date);
    if(date != null){
      controller.updateTime(date);
    }
    print(controller.getDate());
  }
}
