import 'package:carwashapp/ui/widgets/search/searchBody.dart';
import 'package:flutter/material.dart';

import '../../../core/models/serviceModel.dart';

class Search extends StatelessWidget
{
  List<Service> services;
  Search(this.services);
  @override
  Widget build(BuildContext context) {
    return SearchBody(services);
  }
  
}