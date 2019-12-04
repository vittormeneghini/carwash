import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticatedService{

  FirebaseAuth _firebaseAuth;
  UserAuthenticatedService(){
    _firebaseAuth = FirebaseAuth.instance;
  }


  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

}