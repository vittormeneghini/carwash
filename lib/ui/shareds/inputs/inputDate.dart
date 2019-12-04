
import 'package:flutter/material.dart';

class IpuntDate extends StatelessWidget {
  DateTime dateNow = DateTime.now();
  DateTime birthday = DateTime.now();
  
  Function callBackDate;

  IpuntDate(this.callBackDate);

  Future <void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: birthday,
      firstDate: DateTime(1919),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateNow) {
      callBackDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    var btnBirthday = IconButton(
      icon: Icon(
        Icons.date_range,
        size: 30.00,
      ),
      color: Colors.blueGrey,
      onPressed: () => selectDate(context),
    );

    return btnBirthday;
  }
}