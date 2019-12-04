import 'package:carwashapp/ui/shareds/dialogShared/dialogUtil.dart';
import 'package:flutter/material.dart';

PopupMenuItem nextStepButton({dynamic context, Function nextStepContract}) {
  DialogUtil dialogUtil = DialogUtil();

  return PopupMenuItem(
      child: FlatButton(
    child: Row(children: [Icon(Icons.forward), Text("Avançar")]),
    onPressed: () {
      dialogUtil.show(
          title: "Deseja confirmar?",
          acceptText: "Aceitar",
          closeText: "Sair",
          bodyText: "Ao aceitar você irá para etapa de negociação.",
          acceptFuncion: nextStepContract,
          buildContext: context);
    },
  ));
}