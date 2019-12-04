import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/models/serviceModel.dart';
import 'package:carwashapp/ui/widgets/messageWidget/stepperPage.dart';
import 'package:flutter/material.dart';

class WaitConfirm extends StatelessWidget {
  String whoChangedContract;
  Person loggedPerson;
  Person costumer;
  Person collaborator;
  Person whoChangedPerson;
  Contract contract;
  Service service;

  WaitConfirm(
      {this.whoChangedContract,
      this.loggedPerson,
      this.costumer,
      this.collaborator,
      this.contract,
      this.service}) {
    whoChangedPerson =
        costumer.id == whoChangedContract ? costumer : collaborator;
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.blue,
      title: Text(loggedPerson.id == costumer.id
          ? collaborator.fullName
          : costumer.fullName),
    );

    var body = ListView(children: [
      Column(children: [
        StepperPage(
            contract: contract,
            collaborator: collaborator,
            costumer: costumer,
            logged: loggedPerson,
            whoChanged: whoChangedPerson),
        contract.status != 'cancelled'
            ? Container(
                margin: EdgeInsets.all(20),
                child: Column(                  
                  children: [
                    Row(children: [                      
                      Icon(
                        Icons.info,
                        color: Colors.blue[400],
                        size: 50.0,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            'Informações do serviço negociado',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          )),
                    ]),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            color: Colors.green,
                            size: 50.0,
                          ),
                          Container(
                              child: Text(service.price.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.local_car_wash,
                            color: Colors.blue,
                            size: 50.0,
                          ),
                          Container(
                            child: Text(service.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                          )
                        ],
                      ),
                    )
                  ],
                ))
            : Container()
      ])
    ]);

    return Scaffold(body: body, appBar: appBar);
  }
}
