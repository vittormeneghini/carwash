import 'package:carwashapp/core/models/collaboratorServiceViewModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/models/serviceCollaboratorModel.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceCollaboratorService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/ui/views/addServiceView/addServiceView.dart';
import 'package:carwashapp/ui/widgets/addService/cardService.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';

class ListServiceCollaborator extends StatefulWidget {
  @override
  _ListServiceCollaboratorState createState() =>
      _ListServiceCollaboratorState();
}

class _ListServiceCollaboratorState extends State<ListServiceCollaborator> {  
  List<ServiceCollaboratorModel> models;
  List<CollaboratorServiceViewModel> viewModels;
  var serviceCollaboratorService = locator<ServiceCollaboratorService>();
  var serviceService = locator<ServiceService>();
  var authenticatedService = UserAuthenticatedService();
  var personService = locator<PersonService>();
  Person loggedPerson;


  @override
  void initState() {
    getUserLogged();
    getServices();
    super.initState();
  }

  Future<void> getUserLogged() async {
    var currentUser = await authenticatedService.getCurrentUser();

    if (currentUser == null) return;

    var _person = await personService.getPersonByUid(currentUser.uid);

    if (_person == null) return;

    setState(() {
      loggedPerson = _person;
    });
  }

  Future<void> getServices() async {
    var data = await serviceCollaboratorService.fetchServicesCollaborators();
    List<CollaboratorServiceViewModel> _vw =
        List<CollaboratorServiceViewModel>();
    for (var item in data) {
      var _service = await serviceService.getServiceById(item.serviceId.trim());
      _vw.add(CollaboratorServiceViewModel(
          collaboratorServiceId: item.id,
          price: item.price,
          time: item.time,
          serviceName: _service.name));
    }

    setState(() {
      models = data;
      viewModels = _vw;
    });
  }

  Future<void> delete(String id) async {
    await serviceCollaboratorService.removeServiceCollaborator(id);
    await getServices();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Lista de serviços vinculados"),
      ),
      body: ListView(
        children: viewModels == null
            ? [
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: CircularProgressIndicator()),
                )
              ]
            : viewModels.length == 0
                ? [
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Você não possuí nenhum serviço cadastrado",
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center,
                          )),
                    )
                  ]
                : viewModels
                    .map((item) => CardServiceCollaborator(
                          id: item.collaboratorServiceId,
                          nameService: item.serviceName,
                          price: item.price,
                          time: item.time,
                          delete: delete,
                        ))
                    .toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddServiceView(null)));
        },
        label: Text('Adicionar Serviço'),
        icon: Icon(Icons.local_car_wash),
      ),
    );
  }
}
