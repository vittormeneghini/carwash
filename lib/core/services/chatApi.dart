import 'package:cloud_firestore/cloud_firestore.dart';

class ChatApi {
  Stream<QuerySnapshot> streamDataCollection(String contractId){
    return getReference(contractId).orderBy("date_insert", descending: true).snapshots();
  }

  Future<void> addDocument(Map data, String contractId) async {
      await getReference(contractId).document().setData(data);    
  }

  CollectionReference getReference(String contractId){
    return Firestore.instance.collection('contracts').document(contractId).collection('chat');
  }
}