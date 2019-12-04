import 'package:carwashapp/core/models/serviceCollaboratorModel.dart';
import 'package:carwashapp/core/services/collaboratorServiceApi.dart';
import 'package:carwashapp/locator.dart';
import 'package:flutter/material.dart';

class ServiceCollaboratorService extends ChangeNotifier{

  CollaboratorServiceApi _api = locator<CollaboratorServiceApi>();

  List<ServiceCollaboratorModel> servicesCollaborator;

  Future<List<ServiceCollaboratorModel>> fetchServicesCollaborators() async {
    var result = await _api.getDataCollection();
    servicesCollaborator = result.documents.map(
      (doc) => ServiceCollaboratorModel.fromMap(doc.data, doc.documentID)).toList();
    return servicesCollaborator;
  }

    Future<List<ServiceCollaboratorModel>> fetchServicesCollaboratorsByService(String serviceId) async {
    var result = await _api.getDataCollectionByService(serviceId);
    servicesCollaborator = result.documents.map(
      (doc) => ServiceCollaboratorModel.fromMap(doc.data, doc.documentID)).toList();
    return servicesCollaborator;
  }

      Future<List<ServiceCollaboratorModel>> fetchServicesCollaboratorsByCollaborator(String colaboratorId) async {
    var result = await _api.getDataCollectionByCollaborator(colaboratorId);
    servicesCollaborator = result.documents.map(
      (doc) => ServiceCollaboratorModel.fromMap(doc.data, doc.documentID)).toList();
    return servicesCollaborator;
  }

  Future<ServiceCollaboratorModel> getServiceCollaboratorById(String id) async {
    var doc = await _api.getDocumentById(id);
    return ServiceCollaboratorModel.fromMap(doc.data, doc.documentID);
  }

  Future removeServiceCollaborator(String id) async{
     await _api.removeDocument(id) ;
     return ;
  }

  Future<ServiceCollaboratorModel> updateServiceCollaborator(ServiceCollaboratorModel data,String id) async{
    await _api.updateDocument(id, data.toJson()) ;
    return data;
  }

  Future<String> addServiceCollaborator(ServiceCollaboratorModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return result.documentID;
  }

}