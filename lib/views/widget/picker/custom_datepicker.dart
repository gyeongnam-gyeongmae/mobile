import 'package:flutter/material.dart';

class CustomDatepicker extends StatefulWidget {
  const CustomDatepicker({super.key});

  @override
  State<CustomDatepicker> createState() => _CustomDatepicker();
}

class _CustomDatepicker extends State<CustomDatepicker> {
  DateTime? _selectedDate;
  DateTime fiveMinutesLater = DateTime.now().add(const Duration(minutes: 5));
  DateTime oneMonthLater = DateTime.now().add(const Duration(days: 30));

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
            },
            child: Text(
                _selectedDate != null
                    ? _selectedDate.toString().split(" ")[0]
                    : "end date",
                style: const TextStyle(fontSize: 25)),
          )),
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
    showDatePicker(
      context: con,
      initialDate: DateTime.now(),
      firstDate: fiveMinutesLater,
      lastDate: oneMonthLater,
    ).then((selectedDate) => {
          setState(() {
            _selectedDate = selectedDate;
          })
        });
  }
}
