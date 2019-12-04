import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/contractViewModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/contractService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/shareds/fades/fadeIn.dart';
import 'package:carwashapp/ui/widgets/serviceComming/cardServiceComming.dart';
import 'package:flutter/material.dart';

class ServiceComming extends StatefulWidget {
  @override
  _ServiceCommingState createState() => _ServiceCommingState();
}

class _ServiceCommingState extends State<ServiceComming> {
  Person person;
  bool isLoading = true;
  List<Contract> contracts = List<Contract>();
  List<ContractViewModel> vw = List<ContractViewModel>();
  var contractService = locator<ContractService>();
  var service = locator<ServiceService>();
  var personService = locator<PersonService>();
  var authPerson = UserAuthenticatedService();

  @override
  void initState() {
    getContract();
    super.initState();
  }

  Future<void> getContract() async {
    var _user = await authPerson.getCurrentUser();
    var _person = await personService.getPersonByUid(_user.uid);

    setState(() {
      person = _person;
    });

    if (person.type == 'costumer') {
      await getContractByCostumer();
    } else {
      await getContractByCollaborator();
    }

    if (contracts != null) {
      for (var item in contracts) {
        var _service = await service.getServiceById(item.serviceId);
        var _costumer = await personService.getPersonById(item.costumerId);
        var _collaborator =
            await personService.getPersonById(item.collaboratorId);

        var _vw = ContractViewModel();
        _vw.idCollaborator = _collaborator.id;
        _vw.idContract = item.id;
        _vw.idCostumer = _costumer.id;
        _vw.idService = _service.id;
        _vw.nameCollaborator = _collaborator.fullName;
        _vw.nameCostumer = _costumer.fullName;
        _vw.nameService = _service.name;
        _vw.status = item.status;
        _vw.finalPrice = item.finalPrice;
        _vw.imageService = _service.image;

        setState(() {
          vw.add(_vw);
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getContractByCollaborator() async {
    var doc = await contractService.fetchContractsByCollaborator(person.id);

    setState(() {
      contracts = doc.documents.length > 0
          ? doc.documents
              .map((data) => Contract.fromMap(data.data, data.documentID))
              .toList()
          : null;
    });
  }

  Future<void> getContractByCostumer() async {
    var doc = await contractService.fetchContractsByCostumer(person.id);

    setState(() {
      contracts = doc.documents.length > 0
          ? doc.documents
              .map((data) => Contract.fromMap(data.data, data.documentID))
              .toList()
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text("Serviços em Andamento"),
            ),
            body: ListView(
              children: vw
                  .map((item) => FadeIn(4, CardServiceComming(item)))
                  .toList(),
            ),
          );
  }
}
