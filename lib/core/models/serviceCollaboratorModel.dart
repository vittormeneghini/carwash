import 'dart:ffi';

class ServiceCollaboratorModel
{
  String id;
  String collaboratorId;
  String serviceId;
  String price;
  String description;
  String categoryId;
  String time;
  

  ServiceCollaboratorModel({this.collaboratorId, this.serviceId, this.categoryId, this.price, this.description, this.time});

  ServiceCollaboratorModel.fromMap(Map snapShot, String id):
    id = id ?? '',
    collaboratorId = snapShot['collaboratorId'] ?? '',
    serviceId = snapShot['serviceId'] ?? '',
    time = snapShot['time'] ?? '',
    price = snapShot['price'] ?? '0',
    description = snapShot['description'] ?? '',
    categoryId = snapShot['category_id'] ?? '';

  toJson(){
    return {
      "collaboratorId": collaboratorId,
      "serviceId": serviceId,
      "category_id": categoryId,
      "price": price,
      "description": description,
      "time": time
    };
  }
  
}