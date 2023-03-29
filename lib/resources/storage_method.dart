import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //add image to firestorage
  //get the reference to the image to be added
  // upload the image with the reference method
  // get the path to the image url
  // Future<String> uploadImageToFireStorage(String childName,Uint8List file, bool isPost,)async{
  //   Reference ref = _storage.ref(childName).child(_auth.currentUser!.uid);
  //   if(isPost){
  //     String id = const Uuid().v1();
  //     ref = ref.child(id);
  //   }
  //   UploadTask uploadTask = ref.putData(file);
  //   TaskSnapshot snap = await uploadTask;
  //   String downloadUrl = await snap.ref.getDownloadURL();
  //   return downloadUrl;
  // }


  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    Reference ref =
    _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if(isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(
        file
    );

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}