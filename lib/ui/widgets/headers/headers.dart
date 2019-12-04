import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/ui/widgets/headers/headerFavorite.dart';
import 'package:carwashapp/ui/widgets/headers/headerHome.dart';
import 'package:carwashapp/ui/widgets/headers/headerSearch.dart';
import 'package:carwashapp/ui/widgets/headers/headerUnloggedProfile.dart';
import 'package:flutter/material.dart';

List<Widget> getHeaders(int index, Function onchangedSearch, Person loggedPerson) {



  List<Widget> bars = [
    HeaderHome(loggedPerson),
    HeaderFavorite(loggedPerson),
    HeaderSearch(onchangedSearch),
    HeaderUnloggedProfile(loggedPerson: loggedPerson,)
  ];

  return bars;
}
