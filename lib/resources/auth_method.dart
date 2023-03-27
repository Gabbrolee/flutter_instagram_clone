import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/storage_method.dart';
import 'package:flutter_instagram_clone/model/user.dart' as model;

class AuthMethod {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String bio,
      required String username,
      Uint8List? file}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        //register user
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(credential.user!.uid);
        String photoUrl = await StorageMethod()
            .uploadImageToFireStorage("ProfilePics", file!, false);
        // add user to our database
        // the set method help to generate same uid for users and doc unlike the add
        // the add method
        model.User user = model.User(
            username: username,
            email: email,
            uid: credential.user!.uid,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl

        );
        await _firebaseFirestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // login user

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the field";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
