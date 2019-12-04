import 'package:carwashapp/core/models/personModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'messageBallon.dart';

Widget showList(
    {AsyncSnapshot<QuerySnapshot> snapshots,
    Person logged,
    Person collaborator,
    Person costumer}) {
  if (!snapshots.hasData)
    return Center(
      child: Text("Bem vindo ao chat do carwash, inicie uma conversa"),
    );

  return ListView.builder(
    padding: EdgeInsets.all(8.0),
    reverse: true,
    itemCount: snapshots.data.documents.length,
    itemBuilder: (context, int index) {
      var document = snapshots.data.documents[index];
      bool isRight = logged.id == document["from"];
      String whoSend = collaborator.id == document["from"]
          ? collaborator.fullName
          : costumer.fullName;
      return MessageBallon(document["message"], whoSend, isRight);
    },
  );
}
