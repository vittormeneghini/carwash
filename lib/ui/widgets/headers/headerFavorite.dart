import 'package:carwashapp/core/models/personModel.dart';
import 'package:flutter/material.dart';

import 'defaultBar.dart';

class HeaderFavorite extends StatelessWidget {

  Person loggedPerson;
  HeaderFavorite(this.loggedPerson);

  @override
  Widget build(BuildContext context) {
    return DefaultBar(loggedPerson: loggedPerson,);
  }
}
