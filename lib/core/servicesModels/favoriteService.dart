import 'package:carwashapp/core/models/favoriteModel.dart';
import 'package:carwashapp/core/services/favoriteApi.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/widgets/naviWidget/favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteService extends ChangeNotifier {

  FavoriteApi _api = locator<FavoriteApi>();

  Stream<QuerySnapshot> getFavorites () => _api.getDocumentsFavorite();    

  Future<void> unSetFavorite (String favoriteId) async{
    await _api.removeDocument(favoriteId);
  }

  Future<String> setFavorite (FavoriteModel favorite) async{
    var document = await _api.addDocument(favorite);
    return document.documentID;
  }

  Future<FavoriteModel> getFavoriteByCollaborator(String collaboratorId, String loggedId) async {
    var document = await _api.getDocumentByPersonOrService(collaboratorId, loggedId, 'person_id');

    return document.documents.length > 0 ? FavoriteModel.fromMap(document.documents[0].data, document.documents[0].documentID) : null;
  }

    Future<int> getQtdFavoritesByCollaborator(String collaboratorId) async {
    var document = await _api.getDocumentFavoriteCollaborator(collaboratorId);

    return document == null ? 0 : document.documents.length;
  }

    Future<FavoriteModel> getFavoriteByService(String serviceId, String loggedId) async {
    var document = await _api.getDocumentByPersonOrService(serviceId, loggedId, 'service_id');

    return document.documents.length > 0 ? FavoriteModel.fromMap(document.documents[0].data, document.documents[0].documentID) : null;
  }


}