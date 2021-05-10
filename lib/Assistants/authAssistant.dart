library maseeha.auth_assistant;
 import 'package:firebase_auth/firebase_auth.dart';


 _AuthAssitant abc = _AuthAssitant.getInstance();

enum E { username, email, photoURL }
class _AuthAssitant{

   static _AuthAssitant _instance = new _AuthAssitant();

   static _AuthAssitant getInstance() {
    if (_instance == null) {
      _instance = new _AuthAssitant();
    }
    return _instance;
  }



   // ignore: deprecated_member_use
   List<String> userProfileList = List<String>(3);
   

 

void addUserdata(){
  final auth = FirebaseAuth.instance;
    userProfileList[E.username.index] = auth.currentUser.displayName;
    userProfileList[E.email.index] =  auth.currentUser.email;
    userProfileList[E.photoURL.index] =  auth.currentUser.photoURL;


    print("User Name is "+  userProfileList[E.username.index]);
    print("User Email is "+ userProfileList[E.email.index]);

}
}