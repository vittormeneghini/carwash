import 'package:cloud_firestore/cloud_firestore.dart';

class AddressApi{
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  AddressApi(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection(String personId) {
    return ref.document(personId).collection('addresses').getDocuments();
  }

  Future<DocumentSnapshot> getDocumentById(String personId, String id) {
    return ref.document(personId).collection('addresses').document(id).get();
  }

  Future<void> removeDocument(String idPerson, String id) {
    return ref.document(idPerson).collection('addresses').document(id).delete();
  }

  Future<DocumentReference> addDocument(String idPerson, Map data) {
    return ref.document(idPerson).collection('addresses').add(data);
  }

  Future<void> updateDocument(String idPerson, String id, Map data) {
    return ref.document(idPerson).collection('addresses').document(id).updateData(data);
  }
}