
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String description;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List likes;

  Post({
    required this.postUrl,
    required this.profImage,
    required this.postId,
    required this.datePublished,
    required this.description,
    required this.uid,
    required this.username,
    required this.likes
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "username": username,
    "description": description,
    "postId": postId,
    "datePublished": datePublished,
    "profImage": profImage,
    "postUrl": postUrl,
    "likes": likes
  };

  static Post fromSnapshot(DocumentSnapshot snap){
    var snapshot = (snap.data() as Map<String, dynamic>);
    return Post(
        postUrl: snapshot['postUrl'] ?? "",
        profImage: snapshot['profImage'] ?? "",
        postId: snapshot['postId'] ?? "",
        datePublished: DateTime.now(),
        description: snapshot['description'] ?? "",
        uid: snapshot['uid'] ?? "",
        username: snapshot['username'] ?? "",
        likes: snapshot['likes'] ?? ""

    );
  }


}
