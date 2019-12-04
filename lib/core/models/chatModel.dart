class Chat{
  String id;
  String fromId;
  String message;
  DateTime dateInsert;
  dynamic imageUrl;

  Chat({this.fromId, this.message, this.dateInsert, this.imageUrl});

  Chat.fromMap(Map snapShot, String id):
    id = id ?? '',
    fromId = snapShot['from'] ?? '',
    message = snapShot['message'] ?? '',
    dateInsert = snapShot['date_insert'] ?? '',
    imageUrl = snapShot['image_url'] ?? '';

  toJson(){
    return{
      "from": fromId,
      "message": message,
      "date_insert": dateInsert,
      "image_url": imageUrl
    };
  }
}