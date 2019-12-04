import 'package:carwashapp/core/models/personModel.dart';
import 'package:flutter/material.dart';
import 'defaultBar.dart';

class HeaderHome extends StatelessWidget {

  Person loggedPerson;
  HeaderHome(this.loggedPerson);

  @override
  Widget build(BuildContext context) {
    return DefaultBar(loggedPerson: loggedPerson);
  }
}
