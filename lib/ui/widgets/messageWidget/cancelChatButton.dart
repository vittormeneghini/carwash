import 'package:carwashapp/ui/shareds/dialogShared/dialogUtil.dart';
import 'package:flutter/material.dart';

PopupMenuItem cancelChatButton({dynamic context, Function cancelStepContract}) {
  DialogUtil dialogUtil = DialogUtil();
  return PopupMenuItem(
      child: FlatButton(
    child: Row(children: [Icon(Icons.close), Text("Cancelar")]),
    onPressed: () {
      dialogUtil.show(
          title: "Deseja cancelar?",
          acceptText: "Aceitar",
          closeText: "Sair",
          bodyText: "Ao cancelar você não poderá mais interagir no chat.",
          acceptFuncion: cancelStepContract,
          buildContext: context);
    },
  ));
}
