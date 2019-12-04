import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/contractService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StepFunctions {
  Contract contract;
  Person logged;
  ContractService contractService;
  int _index;


  StepFunctions(this.contract, this.logged, this.contractService, this._index);

  activeOrNot(index) {    
    return _index > index ? true : false;
  }

  verifyStepState(index) =>
      activeOrNot(index) ? StepState.complete : StepState.indexed;

  acceptFirstResponse() async {
    return await contractService.acceptFirstStepContract(
        contract.id, logged.id);
  }

  acceptPricingResponse() async {
    return await contractService.acceptFinalPrice(
        contract.id, logged.id);
  }

  sendPrice(String value) async {
    var convert = NumberFormat.simpleCurrency();
    double converted = convert.parse(value);
    return await contractService.sendFinalPrice(
        contract.id, converted, logged.id);
  }

  refuseWaitingPricingResponse() async {
        return await contractService.refuseFinalPrice(
        contract.id, logged.id);
  }

  verifyFunction(String value) async {
    if (contract.status.toLowerCase() == 'waiting_response_talking')
      return acceptFirstResponse();

    if(contract.status.toLowerCase() == 'pricing')      
      return sendPrice(value);

    if (contract.status.toLowerCase() == 'waiting_response_pricing' && logged.id == contract.costumerId)
      return acceptPricingResponse();
  }

  verifyCancelFunction() async {
    if (contract.status.toLowerCase() == 'waiting_response_pricing')
      return refuseWaitingPricingResponse();

      return await contractService.refuseFirstStep(contract.id);
  }

  
}
