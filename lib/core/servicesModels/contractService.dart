import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/services/contractApi.dart';
import 'package:carwashapp/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContractService extends ChangeNotifier {
  ContractApi _api = locator<ContractApi>();

  List<Contract> persons;

  Stream<DocumentSnapshot> fetchContractsAsStream(String id) {
    return _api.streamDataCollection(id);
  }

  Future<Contract> getContractById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Contract.fromMap(doc.data, doc.documentID);
  }

  Future<QuerySnapshot> fetchContractsByCostumer(String id) async {
    var docs = await _api.fetchDocumentsByCostumer(id);
    return docs;
  }

  Future<QuerySnapshot> fetchContractsByCollaborator(String id) async {
    var docs = await _api.fetchDocumentsByCollaborator(id);
    return docs;
  }

  Future<Contract> updateContract(Contract data, String id) async {
    await _api.updateDocument(id, data.toJson());
    return data;
  }

  Future<String> addContract(Contract data) async {
    var result = await _api.addDocument(data.toJson());
    return result.documentID;
  }

  Future<String> existContract(String collaboratorId, String costumerId) async {
    var documents = await _api.existContract(collaboratorId, costumerId);

    return documents.documents.length > 0
        ? documents.documents[0].documentID
        : null;
  }

  Future<void> firstStepContract(String id, String whoChanged) async {
    var contract = await getContractById(id);
    contract.status = "waiting_response_talking";
    contract.whoChanged = whoChanged;
    await _api.updateDocument(id, contract.toJson());
  }

  Future<void> sendFinalPrice(
      String id, double finalPrice, String whoChanged) async {
    var contract = await getContractById(id);
    contract.status = "waiting_response_pricing";
    contract.finalPrice = finalPrice;
    contract.whoChanged = whoChanged;
    await _api.updateDocument(id, contract.toJson());
  }

  Future<void> acceptFinalPrice(String id, String whoChanged) async {
    var contract = await getContractById(id);
    contract.status = "final";
    contract.whoChanged = whoChanged;
    await _api.updateDocument(id, contract.toJson());
  }

  Future<void> refuseFinalPrice(String id, String whoChanged) async {
    var contract = await getContractById(id);
    contract.finalPrice = 0.00;
    contract.status = "waiting_response_pricing";
    contract.whoChanged = whoChanged;
    await _api.updateDocument(id, contract.toJson());
  }

  Future<void> acceptFirstStepContract(String id, String whoChanged) async {
    var contract = await getContractById(id);
    contract.status = "pricing";
    contract.whoChanged = whoChanged;
    await _api.updateDocument(id, contract.toJson());
  }

  Future<void> cancelContract(String id, String whoCancel) async {
    var contract = await getContractById(id);
    contract.status = "cancelled";
    contract.whoCancelled = whoCancel;
    await _api.updateDocument(id, contract.toJson());
  }

  Future<void> refuseFirstStep(String id) async {
    var contract = await getContractById(id);
    contract.status = "talking";
    contract.whoChanged = null;

    await _api.updateDocument(id, contract.toJson());
  }
}
