import 'package:cloud_firestore/cloud_firestore.dart';

class CollaboratorServiceApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  CollaboratorServiceApi(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Future<QuerySnapshot> getDataCollectionByService(String serviceId) {
    return ref.where("serviceId", isEqualTo: serviceId).getDocuments();
  }

    Future<QuerySnapshot> getDataCollectionByCollaborator(String collaboratorId) {
    return ref.where("collaborator_id", isEqualTo: collaboratorId).getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(String id, Map data) {
    return ref.document(id).updateData(data);
  }
}
