import 'package:carwashapp/core/models/favoriteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  FavoriteApi(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDocuments() {
    return ref.getDocuments();
  }

  Future<QuerySnapshot> getDocumentByPersonOrService(String collaboratorId, String loggedId, String personService){
    return ref.where(personService.toString(), isEqualTo: collaboratorId).where('logged_id', isEqualTo: loggedId).getDocuments();
  }

    Future<QuerySnapshot> getDocumentFavoriteCollaborator(String collaboratorId){
    return ref.where('collaborator_id', isEqualTo: collaboratorId).getDocuments();
  }

  Stream<QuerySnapshot> getDocumentsFavorite() {
    return ref.snapshots();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(FavoriteModel favorite){
    return ref.add(favorite.toJson());
  }
}
