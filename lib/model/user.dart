class User {
  final String uid;
  final String photoUrl;
  final String username;
  final List followers;
  final List following;
  final String email;
  final String bio;

  User({
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoUrl,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
        "bio": bio,
        "email": email
      };
}
