import 'package:carwashapp/ui/widgets/addService/addService.dart';
import 'package:flutter/material.dart';

class AddServiceView extends StatelessWidget {

  String id;
  AddServiceView(this.id);

  @override
  Widget build(BuildContext context) {    
    return AddService(id);
  }
}
