import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/contractService.dart';
import 'package:carwashapp/ui/views/naviView/navi.dart';
import 'package:carwashapp/ui/widgets/messageWidget/messageStep.dart';
import 'package:carwashapp/ui/widgets/messageWidget/ruleStepper.dart';
import 'package:carwashapp/ui/widgets/messageWidget/stepFunctions.dart';
import 'package:carwashapp/ui/widgets/messageWidget/steps.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';

class StepperPage extends StatefulWidget {
  Contract contract;
  Person collaborator, costumer, logged, whoChanged;
  StepperPage(
      {this.contract,
      this.collaborator,
      this.costumer,
      this.logged,
      this.whoChanged});

  _StepperPageState createState() =>
      _StepperPageState(contract, collaborator, costumer, logged, whoChanged);
}

class _StepperPageState extends State<StepperPage> {
  TextEditingController _controller = TextEditingController();
  Person collaborator, costumer, logged, whoChanged;
  Contract contract;
  int _index;
  bool _isContinue = false;

  StepFunctions functions;

  var contractService = locator<ContractService>();

  _StepperPageState(this.contract, this.collaborator, this.costumer,
      this.logged, this.whoChanged) {
    _index =
        RuleStepper(contract, logged, _index, whoChanged).verifyIndexState();
    functions = StepFunctions(contract, logged, contractService, _index);
  }

  @override
  Widget build(BuildContext context) {
    if (contract.status == 'cancelled') {
      return Container(
        margin: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Icon(
              Icons.mood_bad,
              size: 70.0,
              color: Colors.blueGrey,
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
                child: Text(
              "O contrato foi cancelado",
              style: TextStyle(fontSize: 25.0),
            )),
            RaisedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Navi()));
              },
            )
          ],
        ),
      );
    }
    else if(contract.status == 'final'){
      return Container(
        margin: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Icon(
              Icons.mood_bad,
              size: 70.0,
              color: Colors.blueGrey,
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
                child: Text(
              "O contrato foi finalizado",
              style: TextStyle(fontSize: 25.0),
            )),
            Container(
              padding: EdgeInsets.only(top: 20.0),
                child: Text(
              "qualquer dúvida entre em contato com o colaborador.",
              style: TextStyle(fontSize: 15.0),
            )),
            RaisedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Navi()));
              },
            )
          ],
        ),
      );
    }
     else {
      MessageStep messages = new MessageStep(whoChanged, _index);

      setIsContinue(String text) {
        setState(() {
          _isContinue = text.length > 0;
        });
      }

      _index =
          RuleStepper(contract, logged, _index, whoChanged).verifyIndexState();

      Steps step = Steps(
          activeOrNot: StepFunctions(contract, logged, contractService, _index)
              .activeOrNot,
          verifyStepState:
              StepFunctions(contract, logged, contractService, _index)
                  .verifyStepState,
          collaborator: collaborator,
          logged: logged,
          messages: messages,
          controller: _controller,
          onChanged: setIsContinue,
          contract: contract);

      Widget _tabStep() => Container(
            margin: EdgeInsets.only(top: 10),
            child: Stepper(
              steps: step.getSteps(),
              currentStep: _index,
              onStepContinue:  RuleStepper(contract, logged, _index, whoChanged)
                          .isValidFunction() ||
                      _isContinue
                  ? () {
                      functions.verifyFunction(_controller.text);
                    }
                  : null,
              onStepCancel: contract.status != 'final'
                  ? functions.verifyCancelFunction
                  : null,
            ),
          );

      return _tabStep();
    }
  }
}
