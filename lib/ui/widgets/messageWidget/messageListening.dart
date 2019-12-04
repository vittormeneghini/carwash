import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'messageList.dart';

listeningMessage(
    {Contract contract, Person logged, Person collaborator, Person costumer, Stream<QuerySnapshot> listen}) {
  return StreamBuilder(
      stream: listen,
      builder: (context, snapshots) {
        return showList(
            snapshots: snapshots,
            logged: logged,
            collaborator: collaborator,
            costumer: costumer);
      });
}
