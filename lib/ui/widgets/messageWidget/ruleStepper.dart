import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';

class RuleStepper {

  Contract contract;
  Person logged, whoChanged;
  int _index;

  RuleStepper(this.contract, this.logged, this._index, this.whoChanged);

  verifyIndexState() {
    if (contract.status.toLowerCase() == 'talking' ||
        contract.status.toLowerCase() == 'waiting_response_talking') _index = 0;
    if (contract.status.toLowerCase() == 'pricing' ||
        contract.status.toLowerCase() == 'waiting_response_pricing') _index = 1;

    if(contract.status.toLowerCase() == 'final') _index = 2;

    return _index;
  }

  isValidFunction() =>
      (contract.status.toLowerCase() == 'waiting_response_talking' &&
          logged.id != whoChanged.id) ||
      contract.status.toLowerCase() == 'waiting_response_pricing';
}
