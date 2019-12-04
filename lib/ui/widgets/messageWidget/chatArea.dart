import 'package:carwashapp/core/models/chatModel.dart';
import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/chatService.dart';
import 'package:carwashapp/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './messageChat.dart';
import 'messageListening.dart';

class ChatArea extends StatefulWidget {
  Person costumer;
  Person collaborator;
  Contract contract;
  Person loggedPerson;

  ChatArea(
      {this.costumer, this.collaborator, this.contract, this.loggedPerson});

  _ChatAreaState createState() =>
      _ChatAreaState(costumer, collaborator, contract, loggedPerson);
}

class _ChatAreaState extends State<ChatArea> {
  Person _costumer;
  Person _collaborator;
  Contract _contract;
  Person _logged;

  var chatService = locator<ChatService>();

  StreamBuilder<QuerySnapshot> listMessages = null;

  _ChatAreaState(
      this._costumer, this._collaborator, this._contract, this._logged) {
    listMessages = listeningMessage(
        contract: _contract,
        logged: _logged,
        collaborator: _collaborator,
        costumer: _costumer,
        listen: chatService.fetchPersonsAsStream(_contract.id));
  }

  void _handleSubmit({String text, dynamic imageUrl}) async {
    Chat chat =
        Chat(dateInsert: DateTime.now(), message: text, fromId: _logged.id, imageUrl: imageUrl);
    await chatService.addChat(chat, _contract.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(child: listMessages),
        Divider(height: 5.0),
        MessageChat(
          handleSubmit: _handleSubmit,
          contract: _contract,
          loggedPerson: _logged,
        ),
      ],
    ));
  }
}
