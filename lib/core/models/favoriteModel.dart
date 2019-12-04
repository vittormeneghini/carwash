import 'package:cloud_firestore/cloud_firestore.dart';

class   FavoriteModel{
  String id;
  Timestamp dateFavorite;
  String personId; 
  String serviceId;
  String loggedId;

  FavoriteModel({ this.dateFavorite, this.personId, this.loggedId, this.serviceId});

  FavoriteModel.fromMap(Map snapshot, String id): 
    id = id ?? '',
    dateFavorite = snapshot['date_favorite'] ?? '',
    personId = snapshot['person_id'] ?? '',
    loggedId = snapshot['logged_id'] ?? '',
    serviceId = snapshot['service_id'] ?? '';

    toJson(){

      String personService = personId != null && personId.isNotEmpty ? "person_id" : "service_id";
      String value = personId != null && personId.isNotEmpty ? personId : serviceId;

      return {
        "date_favorite": dateFavorite,
        personService.toString(): value,
        "logged_id": loggedId        
      };
    }
}