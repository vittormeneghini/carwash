import 'package:cloud_firestore/cloud_firestore.dart';

class ContractApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference _rf;

  ContractApi(this.path){
    _rf = _db.collection(path);
  }
  
  Stream<DocumentSnapshot> streamDataCollection(String id){
    return _rf.document(id).snapshots();
  }

  Future<QuerySnapshot> existContract(String collaboratorId, String costumerId)
  {
    return _rf.where("collaborator_id", isEqualTo: collaboratorId).where("costumer_id", isEqualTo: costumerId).where("status", isEqualTo: 'talking').getDocuments();
  }

  Future<DocumentReference> addDocument(Map data){
    return _rf.add(data);
  }

  Future<void> updateDocument(String id, Map data) {
    return _rf.document(id).updateData(data);
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return _rf.document(id).get();
  }

  Future<QuerySnapshot> fetchDocumentsByCollaborator(String id) async {
    return _rf.where('collaborator_id', isEqualTo: id).getDocuments();
  }

  Future<QuerySnapshot> fetchDocumentsByCostumer(String id) async {
    return _rf.where('costumer_id', isEqualTo: id).getDocuments();
  }
}