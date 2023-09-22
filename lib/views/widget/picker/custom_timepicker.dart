import 'package:flutter/material.dart';

class CustomTimepicker extends StatefulWidget {
  const CustomTimepicker({super.key});

  @override
  State<CustomTimepicker> createState() => _CustomTimepickerState();
}

class _CustomTimepickerState extends State<CustomTimepicker> {
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
            child: Text(
              '$_selectedTime',
              style: const TextStyle(fontSize: 25),
            ),
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
    Future<TimeOfDay?> future =
        showTimePicker(context: con, initialTime: TimeOfDay.now());

    future.then((timeOfDay) {
      setState(() {
        if (timeOfDay == "end time") {
          _selectedTime = "end time";
        } else {
          _selectedTime = '${timeOfDay?.hour}시 ${timeOfDay?.minute}분';
        }
      });
    });
  }
}
