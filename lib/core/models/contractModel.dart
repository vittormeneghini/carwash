class Contract{
  String id;
  String collaboratorId;
  String costumerId;
  double finalPrice;
  String status;
  String whoChanged;
  String whoCancelled;
  String serviceId;

  Contract({this.collaboratorId,this.costumerId, this.serviceId, this.finalPrice, this.status});

  Contract.fromMap(Map snapShot, String id) : 
    id = id ?? '',
    collaboratorId = snapShot['collaborator_id'] ?? 0,
    costumerId = snapShot['costumer_id'] ?? '',
    serviceId = snapShot['service_id'] ?? '',
    finalPrice = double.parse(snapShot['final_price'].toString()),
    status = snapShot['status'] ?? '',
    whoChanged = snapShot['who_changed'] ?? '',
    whoCancelled = snapShot['who_cancelled'] ?? '';

  toJson(){
    return{
      "collaborator_id": collaboratorId,
      "costumer_id": costumerId,
      "service_id": serviceId,
      "final_price": finalPrice,
      "status": status,
      "who_changed": whoChanged,
      "who_cancelled": whoCancelled
    };
  }

}