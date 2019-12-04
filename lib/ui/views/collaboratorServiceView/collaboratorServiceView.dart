import 'package:carwashapp/ui/widgets/collaboratorService/loadCardCollaborator.dart';
import 'package:flutter/material.dart';

class CollaboratorServiceView extends StatelessWidget {  

  String serviceId;
  CollaboratorServiceView({this.serviceId});

  @override
  Widget build(BuildContext context) {
    return LoadCardCollaborator(serviceId: serviceId,);
  }
}