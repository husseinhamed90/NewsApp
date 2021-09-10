import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'package:loginpagechallenge/Models/UserAccount.dart';


class FirebaseAPIs{

  static Future<UserAccount?> login(String username,String password)async{
    try {
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password
      );
      Map<String,dynamic> dd =await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.uid).get().then((value) {
        return value.data()!;
      });
      return UserAccount.fromJson(dd);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  static Future<UserAccount?> register(UserAccount account)async{
    try {
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: account.username,
          password: account.password
      );
      account.id=userCredential.user!.uid;
      print(account.toJson());

      DocumentReference documentReference = FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.uid);
      documentReference.set(account.toJson());
      return account;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}