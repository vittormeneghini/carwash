import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/models/serviceModel.dart';
import 'package:carwashapp/core/servicesModels/contractService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/shareds/loaderShared/loaderGif.dart';
import 'package:carwashapp/ui/widgets/messageWidget/waitConfirm.dart';
import 'package:flutter/material.dart';
import 'appBarChat.dart';
import 'chatArea.dart';

class ListenContract extends StatefulWidget {
  String contractId;
  ListenContract({this.contractId});

  _ListenContractState createState() =>
      _ListenContractState(contractId: contractId);
}

class _ListenContractState extends State<ListenContract> {
  String contractId;
  _ListenContractState({this.contractId});

  Contract contract;
  Person costumer;
  Person collaborator;
  Person loggedPerson;
  Service serviceModel;
  var personService = locator<PersonService>();
  var contractService = locator<ContractService>();
  var service = locator<ServiceService>();
  var authService = UserAuthenticatedService();
  

  @override
  void initState() {
    super.initState();
    _getPageRequired();
  }
  

  Future<void> _getPageRequired() async {
    Contract contract = await contractService.getContractById(contractId);
    Person costumer = await personService.getPersonById(contract.costumerId);
    Person collaborator =
        await personService.getPersonById(contract.collaboratorId);
    var _user = await authService.getCurrentUser();    
    Person loggedPerson =
        await personService.getPersonByUid(_user.uid);
    var _service = await service.getServiceById(contract.serviceId);

    setState(() {
      serviceModel = _service;
      this.contract = contract;
      this.costumer = costumer;
      this.collaborator = collaborator;
      this.loggedPerson = loggedPerson;
    });
  }

  Future<void> acceptFirstStep() async {
    await contractService.firstStepContract(contract.id, loggedPerson.id);
  }

  Future<void> cancel() async {
    await contractService.cancelContract(contract.id, loggedPerson.id);
  }

  @override
  Widget build(BuildContext context) {
    bool _verifyLoadedStates() =>
        !(costumer == null || collaborator == null || contract == null);

    return StreamBuilder(
      stream: contractService.fetchContractsAsStream(contractId),
      builder: (context, snap) {
        if (!_verifyLoadedStates()) {
          return LoaderGif();
        }

        if (snap.data['status'] != 'talking') {
          contract.status = snap.data['status'];
          contract.finalPrice = snap.data['final_price'];
          return WaitConfirm(
            loggedPerson: loggedPerson,
            whoChangedContract: snap.data['who_changed'],
            collaborator: collaborator,
            costumer: costumer,
            contract: contract,
            service: serviceModel,
          );
        }

        var appBar = renderAppBar(
            fromName: loggedPerson.id == costumer.id
                ? collaborator.fullName
                : costumer.fullName,
            nextStepContract: acceptFirstStep,
            cancelStepContract: () {
              cancel();
            });

        var body = ChatArea(
            costumer: costumer,
            collaborator: collaborator,
            contract: contract,
            loggedPerson: loggedPerson);

        return Scaffold(body: body, appBar: appBar);
      },
    );
  }
}
