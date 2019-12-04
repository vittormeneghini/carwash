import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/services/personApi.dart';
import 'package:carwashapp/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonService extends ChangeNotifier {
  PersonApi _api = locator<PersonApi>();

  List<Person> persons;

  Future<List<Person>> fetchPersons() async {
    var result = await _api.getDataCollection();
    persons = result.documents
        .map((doc) => Person.fromMap(doc.data, doc.documentID))
        .toList();
    return persons;
  }

  Stream<QuerySnapshot> fetchPersonsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Person> getPersonById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Person.fromMap(doc.data, doc.documentID);
  }

  Future <Person> getPersonbyEmail(String email) async {
    var result = await _api.getDocmentByEmail(email);
    return result.documents.length > 0 ? Person.fromMap(result.documents[0].data, result.documents[0].documentID): null;
  }

  Future removePerson(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future<Person> updatePerson(Person data, String id) async {
    await _api.updateDocument(id, data.toJson());
    return data;
  }

  Future<String> addPerson(Person data) async{
    if(await isEmailRegistred(data.email)) {
      var result  = await _api.addDocument(data.toJson());
      return result.documentID;
    } else {
      return null;
    }
  }
    
   Future <bool> isEmailRegistred(String email) async {
    var data = await getPersonbyEmail(email);
    return data != null;
   }

  Future<double> calculateRates(String personId) async {
    var rates = await _api.getRates(personId);

    int sumRate = 0;
    rates.documents.forEach((item) {
      sumRate += item.data['rate'];
    });

    if (sumRate == 0 && rates.documents.length == 0) return 0;

    return sumRate / rates.documents.length;
  }

  Future<Person> getPersonByUid(String uid) async{
    var result = await _api.getPersonByUid(uid);
    return result.documents.length > 0 ? Person.fromMap(result.documents[0].data, result.documents[0].documentID) : null;
  }
}
