import 'package:flutter/material.dart';
import 'cancelChatButton.dart';
import 'nextStepButton.dart';

AppBar renderAppBar({String fromName, Function nextStepContract, Function cancelStepContract}) {
  return AppBar(
    backgroundColor: Colors.blue,
    title: Text(fromName),
    actions: <Widget>[
      PopupMenuButton(
        icon: Icon(Icons.dehaze),
        itemBuilder: (context) => [
          nextStepButton(context: context, nextStepContract: nextStepContract),
          cancelChatButton(context: context, cancelStepContract: cancelStepContract),
        ],
      )
    ],
  );
}
