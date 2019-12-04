import 'package:carwashapp/core/models/favoriteModel.dart';
import 'package:carwashapp/ui/widgets/favorite/cardFavoriteCollaborator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cardFavoriteService.dart';

class DefaultListen extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot> snapshots;
  String notFoundMessage;
  bool isService;
  DefaultListen({this.snapshots, this.notFoundMessage, this.isService = true});

  @override
  Widget build(BuildContext context) {
    return snapshots.data != null && snapshots.data.documents.length > 0
        ? Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(2.0),
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, int index) {
                var content = snapshots.data.documents[index];
                var fav =
                    FavoriteModel.fromMap(content.data, content.documentID);
                return isService
                    ? CardFavoriteService(
                        logged: null,
                        favorite: fav,
                        serviceId: content['service_id'],
                      )
                    : CardFavoriteCollaborator(
                        collaboratorId: content['person_id'],
                        favorite: fav,                        
                      );
              },
            ),
          )
        : snapshots.data != null && snapshots.data.documents.length <= 0
            ? Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 30.0),
                child: Text(notFoundMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0)),
              )
            : Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Center(child: CircularProgressIndicator()),
              );
  }
}
