import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile/controller/map_controller.dart';

class LocationDropdown extends StatefulWidget {
  const LocationDropdown({super.key});

  @override
  State<LocationDropdown> createState() => _LocationDropdownState();
}

//앱바 오른쪽 드롭다운으로 만들었지만 나중에 지도api호출해서 값 반영해야할 듯
class _LocationDropdownState extends State<LocationDropdown> {
  final MapController mapController = Get.find<MapController>();

  final _cities = ['김해시'];

  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    setState(() {
      print(_cities[0]);
      _selectedCity = _cities[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mapController.city.value.isNotEmpty && _cities.length < 2) {
      _cities.add(mapController.city.value);
      print("1");
    }
    return Scaffold(
        body: SizedBox(
            width: 250,
            child: DropdownButton(
              value: _selectedCity,
              padding: const EdgeInsets.fromLTRB(18, 15, 0, 0),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              underline: const SizedBox.shrink(),
              items: _cities
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value!;
                });
              },
            )));
  }
}
