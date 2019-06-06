
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class UserModel extends Model {


  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String,dynamic> userData = Map();


  final GoogleSignIn googleSignIn = GoogleSignIn();
  

  bool isLoading = false;


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    loadCurrentUser();

  }

  void signUp({@required Map<String,dynamic>userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail }){
      isLoading = true;
      notifyListeners();

      _auth.createUserWithEmailAndPassword(
          email: userData["email"],
          password: pass
      ).then((user) async{

        firebaseUser = user;
        userData["picture"] = "";
        await _saveUserData(userData);

        onSuccess();
        isLoading = false;
        notifyListeners();

      }).catchError((e){

        onFail();
        isLoading = false;
        notifyListeners();

      });
  }
  void signOut() async{
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }
  void signIn({@required String email, @required String pass,@required VoidCallback onSuccess, @required VoidCallback onFail}) async{
     isLoading = true;
     notifyListeners();

     _auth.signInWithEmailAndPassword(email: email, password: pass).then(
             (user) async{

              firebaseUser = user;

              await loadCurrentUser();
              onSuccess();
              isLoading = false;
              notifyListeners();
     }).catchError((e){
        onFail();
        isLoading = false;
        notifyListeners();
     });
  }

  void signInGoogle({@required VoidCallback onSuccess, @required VoidCallback onFail}) async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSa = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: gSa.accessToken,
        idToken: gSa.idToken
    );

    _auth.signInWithCredential(credential).then((user) async{

      firebaseUser = user;
      userData["name"] = user.displayName;
      userData["email"] = user.email;
      userData["picture"] = user.photoUrl;
      userData["number"] = user.phoneNumber;



      DocumentSnapshot docUser =
      await Firestore.instance.collection("users").document(firebaseUser.uid).get();

      if(docUser.data == null){
        _saveUserData(userData);
      }

      await loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

 Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> savePicture(Map<String, dynamic> userData,File image) async{
    this.userData = userData;

    //Criar uma referencia para am foto
    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(firebaseUser.uid);

    //Salva a foto na referencia
    final StorageUploadTask task = firebaseStorageRef.putFile(image);

    //Pega a url de download da foto(Usado para mostrar a foto independente do dispositivo que usuario logou)
    var dowurl = await (await task.onComplete).ref.getDownloadURL();

    // Transforma a url em uma String(Não sei se é necessário fazer essa conversão)
    String url = dowurl.toString();

    //Inclui no map a url
    userData["picture"] = url;

    //Salva no banco de dados
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);

    //Notifica a todos que houve mudança
    notifyListeners();
  }

 Future<Null> loadCurrentUser() async{
    if(firebaseUser == null){
      firebaseUser = await _auth.currentUser();
    }
    if(firebaseUser != null){
      if(userData["name"] == null){
        DocumentSnapshot docUser =
        await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData =  docUser.data;
      }
    }
    notifyListeners();
 }


}