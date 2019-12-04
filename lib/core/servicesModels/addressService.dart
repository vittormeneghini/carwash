import 'package:carwashapp/core/models/addressModel.dart';
import 'package:carwashapp/core/services/addressApi.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class AddressService extends ChangeNotifier{
  AddressApi _api = locator<AddressApi>();

  List<Address> addresses;

  Future<List<Address>> fetchAddresses(String idPerson) async {
    var result = await _api.getDataCollection(idPerson);
    addresses = result.documents
        .map((doc) => Address.fromMap(doc.data, doc.documentID))
        .toList();
    return addresses;
  }

  Future<Address> getAddressById(String personId, String id) async {
    var doc = await _api.getDocumentById(personId, id);
    return Address.fromMap(doc.data, doc.documentID);
  }

  Future removeAddress(String personId, String id) async {
    await _api.removeDocument(personId, id);
    return;
  }

  Future<Address> updateAddress(String personId, Address data, String id) async {
    await _api.updateDocument(personId, id, data.toJson());
    return data;
  }


  Future<String> addAddress(String personId, Address data) async {
    var result = await _api.addDocument(personId, data.toJson());
    return result.documentID;
  }
}