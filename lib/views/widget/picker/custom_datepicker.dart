import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/date_picker_controller.dart';

class CustomDatepicker extends GetView<DatePickerController> {
  DateTime fiveMinutesLater = DateTime.now().add(const Duration(minutes: 5));
  DateTime oneMonthLater = DateTime.now().add(const Duration(days: 30));

  CustomDatepicker({super.key});

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
          Container(
              child: InkWell(
            onTap: () {
              showDate(context);
              FocusScope.of(context).unfocus();
            },
            child: Obx(() {
              return Text(
                controller.selectedDate.value != null
                    ? controller.selectedDate.value.toString().split(" ")[0]
                    : "end date",
                style: const TextStyle(fontSize: 25));
          }))),
          IconButton(
            icon: const Icon(Icons.calendar_month, size: 30),
            onPressed: () {
              showDate(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> showDate(BuildContext con) async {
    final date = await showDatePicker(
      context: con,
      initialDate: fiveMinutesLater,
      firstDate: fiveMinutesLater,
      lastDate: oneMonthLater,
    );
    print(date);
    if (date != null) {
      controller.updateDate(date);
    }
  }
}
