import 'package:cloud_firestore/cloud_firestore.dart';

class PersonApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  PersonApi(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<QuerySnapshot> getDocmentByEmail(String email) {
    return ref.where('email', isEqualTo: email).getDocuments();
  }

  Future<QuerySnapshot> getPersonByUid(String uid){
    return ref.where('uid', isEqualTo: uid).getDocuments();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<QuerySnapshot> getRates(String personId) {
    return ref.document(personId).collection('rates').getDocuments();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(String id, Map data) {
    return ref.document(id).updateData(data);
  }
}
