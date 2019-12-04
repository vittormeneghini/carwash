import 'package:carwashapp/core/models/serviceModel.dart';
import 'package:carwashapp/core/services/serviceApi.dart';
import 'package:carwashapp/locator.dart';
import 'package:flutter/foundation.dart';

class ServiceService extends ChangeNotifier {
  ServiceApi _api = locator<ServiceApi>();

  List<Service> services;

  Future<Service> getServiceById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Service.fromMap(doc.data, doc.documentID);
  }

  Future<Service> updateService(Service data, String id) async {
    await _api.updateDocument(id, data.toJson());
    return data;
  }

  Future<void> addService(Service data) async {
    await _api.addDocument(data.toJson());
  }

  Future<double> calculateRates(String serviceId) async {
    var rates = await _api.getRates(serviceId);

    int sumRate = 0;
    rates.documents.forEach((item) {
      sumRate += item.data['rate'];
    });

    if (sumRate == 0 && rates.documents.length == 0) return 0;

    return sumRate / rates.documents.length;
  }

  Future<List<Service>> fetchServices() async {
    var result = await _api.getDataCollection();
    services = result.documents
        .map((doc) => Service.fromMap(doc.data, doc.documentID))
        .toList();
    return services;
  }

  Future<List<Service>> fetchServicesByCategory(String categoryId) async {
    var result = await _api.getDataCollection();
    services = result.documents
        .where((document) {
          return document.data['category_id'] == categoryId;
        })
        .map((doc) => Service.fromMap(doc.data, doc.documentID))
        .toList();
    return services;
  }

  Future<List<Service>> fetchServicesByName(String text) async {
    var result = await _api.getDataCollection();

    services = result.documents
        .map((doc) => Service.fromMap(doc.data, doc.documentID))
        .toList();

    var newServices = services.where((service) {
      return service.name.toLowerCase().contains(text.toLowerCase());
    }).toList();

    return newServices;
  }
}
