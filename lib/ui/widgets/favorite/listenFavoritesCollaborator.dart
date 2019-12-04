import 'package:carwashapp/ui/widgets/favorite/defaultListen.dart';
import 'package:flutter/material.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../locator.dart';

class ListenFavoritesCollaborator extends StatefulWidget {
  @override
  _ListenFavoritesCollaboratorState createState() =>
      _ListenFavoritesCollaboratorState();
}

class _ListenFavoritesCollaboratorState
    extends State<ListenFavoritesCollaborator> {
  var favoriteService = locator<FavoriteService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: favoriteService.getFavorites(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.data != null)
          snapshots.data.documents
              .removeWhere((item) => item['person_id'] == null);

        return DefaultListen(snapshots: snapshots, isService: false, notFoundMessage: "Você ainda não possuí colaboradores na sua lista de favoritos",);
      },
    );
  }
}
