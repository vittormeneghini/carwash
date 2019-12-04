import 'package:carwashapp/ui/widgets/favorite/defaultListen.dart';
import 'package:flutter/material.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../locator.dart';

class ListenFavoritesServices extends StatefulWidget {
  @override
  _ListenFavoritesServicesState createState() =>
      _ListenFavoritesServicesState();
}

class _ListenFavoritesServicesState extends State<ListenFavoritesServices> {
  var favoriteService = locator<FavoriteService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: favoriteService.getFavorites(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.data != null)
          snapshots.data.documents
              .removeWhere((item) => item['service_id'] == null);

        return DefaultListen(
          snapshots: snapshots,
          notFoundMessage: "Você ainda não possuí serviços na lista de favoritos",
          isService: true,          
        );
      },
    );
  }
}
