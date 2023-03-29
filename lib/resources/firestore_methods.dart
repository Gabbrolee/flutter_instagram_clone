
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

import '../model/post.dart';

class FirestoreMethod{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //
  // Future<String>uploadPost(
  //     String description,
  //     Uint8List file,
  //     String uid,
  //     String username,
  //     String profImage
  //     ) async{
  //   String res = "Some errors occurs";
  //   try{
  //    String photoUrl = await StorageMethod().uploadImageToFireStorage('posts', file, true);
  //
  //    String postId = const Uuid().v1();
  //    Post post = Post(
  //        postUrl: photoUrl,
  //        profImage: profImage,
  //        postId: postId,
  //        datePublished: DateTime.now(),
  //        description: description,
  //        uid: uid,
  //        username: username,
  //        likes: []
  //    );
  //    _firebaseFirestore.collection('post').doc(postId).set(post.toJson());
  //    res = 'success';
  //   }catch(err){
  //     res = err.toString();
  //   }
  //   return res;
  // }

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
      await StorageMethod().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firebaseFirestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// check if a post has been like then add if not
  Future<void> likePost(String postId, String uid, List likes)async{
   try{
      if(likes.contains(uid)){
        await _firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
   }catch(e){
     print(e.toString());
   }
  }

  Future<void> postComment(String postId, String text, String uid, String name, String profilePics) async{
    try{
      if(text.isNotEmpty){
        String commentId = const Uuid().v1();
       await  _firebaseFirestore.collection("posts").doc(postId).collection('comments').doc(commentId).set({
          'profilePics': profilePics,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId':commentId,
          'datePublished': DateTime.now()
        });
      }else {
        print('Text is empty');
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async{
    try{
     await  _firebaseFirestore.collection('posts').doc(postId).delete();


    }catch(e){
      print(e.toString());
    }
  }

}