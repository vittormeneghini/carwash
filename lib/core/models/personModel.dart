import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String id;
  String uid;
  Timestamp birthday;
  String cpf;
  String email;
  String fullName;
  String password;
  String phone;
  String image;
  String type;
  String collaboratorService;

  Person({ this.birthday, this.cpf, this.email, this.fullName, this.password, this.phone, this.image, this.uid, this.type });

  Person.fromMap(Map snapshot, String id): 
    id = id ?? '',
    uid = snapshot['uid'] ?? '',
    birthday =  snapshot['birthday'] ?? '',
    cpf =  snapshot['cpf'] ?? '',
    email =  snapshot['email'] ?? '',
    fullName =  snapshot['full_name'] ?? '',
    password =  snapshot['password'] ?? '',
    phone =  snapshot['phone'] ?? '',
    image = snapshot['image'] ?? '',
    type = snapshot['type'] ?? '';

    toJson(){
      return {
        "uid": uid,
        "birthday": birthday,
        "cpf": cpf,
        "email": email,
        "full_name": fullName,
        "password": password,
        "phone": phone,
        "image": image,
        "type": type
      };
    }
}