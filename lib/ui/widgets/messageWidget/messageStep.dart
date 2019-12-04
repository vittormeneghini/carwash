import 'package:carwashapp/core/models/personModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageStep {

  Person whoChanged;
  int _index;
  NumberFormat format;
  MessageStep(this.whoChanged, this._index)
  {
    format = NumberFormat.simpleCurrency(locale: 'pt-br');
  }

  Widget returnContentAprovation() => _index > 0
      ? Text("O serviço foi aprovado.")
      : Text(
          "${whoChanged.fullName} deseja avançar para a etapa de negociação de valores.");

  Widget returnTitlePricingAprovation(double finalprice) => _index > 1
      ? Text("Negociação no valor de ${format.format(finalprice)} aprovada")
      : Text("Negociação de valores.");

  Widget returnContentPricingAprovation(double finalprice, String status) => _index > 1 && status.toLowerCase() == 'final'
      ? Text("Valor de ${format.format(finalprice)} foi aprovado durante a negociação.")
      : _index == 1 && status.toLowerCase() == 'waiting_response_pricing' ? Text("Colaborador deseja finalizar o serviço no valor de ${format.format(finalprice)}.") : Text("Aguardando a definição do colaborador sobre o valor do serviço.");
}
