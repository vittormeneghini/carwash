import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:flutter/material.dart';

import 'cameraButton.dart';

class MessageChat extends StatefulWidget {
  Function handleSubmit;
  Contract contract;
  Person loggedPerson;
  MessageChat({this.handleSubmit, this.contract, this.loggedPerson});

  _MessageChatState createState() =>
      _MessageChatState(handleSubmit: handleSubmit, contract: contract, loggedPerson: loggedPerson);
}

class _MessageChatState extends State<MessageChat> {
  TextEditingController _msgController = TextEditingController();

  bool _isComposing = false;
  Function handleSubmit;
  Contract contract;
  Person loggedPerson;

  _MessageChatState({this.handleSubmit, this.contract, this.loggedPerson});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CameraButton(contract: contract, loggedPerson: loggedPerson),
        Expanded(
          child: TextField(
            controller: _msgController,
            decoration:
                InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
            onChanged: (text) {
              setState(() {
                _isComposing = text.length > 0;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: _isComposing
              ? () {
                  handleSubmit(text: _msgController.text, imageUrl: null);
                  _msgController.clear();
                  setState(() {
                    _isComposing = false;
                  });
                }
              : null,
        )
      ],
    );
  }
}
