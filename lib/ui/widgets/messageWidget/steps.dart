import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/ui/shareds/currency/currencyInputFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'messageStep.dart';

class Steps {
  Function activeOrNot, verifyStepState;
  Person logged, collaborator;
  MessageStep messages;
  TextEditingController controller;
  Function onChanged;
  Contract contract;

  Steps(
      {this.logged,
      this.collaborator,
      this.activeOrNot,
      this.verifyStepState,
      this.messages,
      this.controller,
      this.onChanged,
      this.contract});

  getSteps() {
    var steps = [
      Step(
          title: Text("Aprovação do serviço"),
          content: messages.returnContentAprovation(),
          isActive: activeOrNot(0),
          state: verifyStepState(0)),
      Step(
          title: messages.returnTitlePricingAprovation(contract.finalPrice),
          content: messages.returnContentPricingAprovation(contract.finalPrice, contract.status),
          isActive: activeOrNot(1),
          state: verifyStepState(1)),
      Step(
          title: Text("Finalização"),
          content: Text("Serviço Finalizado"),
          isActive: activeOrNot(2),
          state: verifyStepState(2)),
    ];

    if (collaborator.id == logged.id) {
      steps.removeAt(1);

      steps.insert(
          1,
          Step(
              title: Text("Informe para o cliente o valor final."),
              content: TextField(
                controller: controller,
                decoration:
                    InputDecoration.collapsed(hintText: "Digite o valor final"),
                onChanged: (text) {
                  onChanged(text);
                },
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  new CurrencyInputFormatter()
                ],
                keyboardType: TextInputType.number,
              ),
              isActive: activeOrNot(2),
              state: verifyStepState(2)));
    }

    return steps;
  }
}
