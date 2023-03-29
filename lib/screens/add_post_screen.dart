// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_instagram_clone/providers/users_provider.dart';
// import 'package:flutter_instagram_clone/resources/firestore_methods.dart';
// import 'package:flutter_instagram_clone/utils/colour.dart';
// import 'package:flutter_instagram_clone/utils/utils.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../model/user.dart';
//
// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddPostScreen> createState() => _AddPostScreenState();
// }
//
// class _AddPostScreenState extends State<AddPostScreen> {
//   Uint8List? _file;
//   final TextEditingController _descriptionController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   Future<void> postImage(String uid, String profImage, String username) async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       String res = await FirestoreMethod().uploadPost(
//           _descriptionController.text, _file!, uid, username, profImage);
//       if (res == "success") {
//         setState(() {
//           _isLoading = false;
//         });
//         showSnackBar("Posted!", context);
//         clearImage();
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         showSnackBar(res, context);
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       showSnackBar(e.toString(), context);
//     }
//   }
//
//   void _selectImage(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return SimpleDialog(
//             title: Text("Create a post"),
//             children: [
//               SimpleDialogOption(
//                 padding: EdgeInsets.all(20),
//                 child: Text("Take a photo"),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.camera);
//                   setState(() {
//                     _file = file;
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: EdgeInsets.all(20),
//                 child: const Text("Choose a photo"),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.gallery);
//                   setState(() {
//                     _file = file;
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                   padding: EdgeInsets.all(20),
//                   child: const Text("Cancel"),
//                   onPressed: () => Navigator.of(context).pop())
//             ],
//           );
//         });
//   }
//
//    void clearImage(){
//     setState(() {
//       _file = null;
//     });
//    }
//   @override
//   Widget build(BuildContext context) {
//     final UsersProvider userProvider = Provider.of<UsersProvider>(context);
//     print("This: ${userProvider.getUser.photoUrl}");
//     return _file == null
//         ? Center(
//             child: IconButton(
//               onPressed: () => _selectImage(context),
//               icon: const Icon(Icons.upload),
//             ),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.black,
//               title: const Text('Post to'),
//               leading: IconButton(
//                   onPressed: ()=> clearImage(),
//                   icon: const Icon(Icons.arrow_back)),
//               actions: [
//                 TextButton(
//                     onPressed: () => postImage(
//                         userProvider.getUser.uid,
//                         userProvider.getUser.photoUrl,
//                         userProvider.getUser.username),
//                     child: const Text(
//                       "Post",
//                       style: TextStyle(
//                           color: Colors.blueAccent,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16),
//                     ))
//               ],
//             ),
//             body: Column(
//               children: [
//                 _isLoading
//                     ? const LinearProgressIndicator()
//                     : const Padding(padding: EdgeInsets.only(top: 0.0)),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         userProvider.getUser.photoUrl,
//                         // "https://images.unsplash.com/photo-1591280063444-d3c514eb6e13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2VzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60"
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       child: TextField(
//                         controller: _descriptionController,
//                         decoration: const InputDecoration(
//                           hintText: "write a caption...",
//                           border: InputBorder.none,
//                         ),
//                         maxLines: 8,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 45,
//                       width: 45,
//                       child: AspectRatio(
//                         aspectRatio: 487 / 451,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: MemoryImage(_file!),
//                                   fit: BoxFit.fill,
//                                   alignment: FractionalOffset.topCenter)),
//                         ),
//                       ),
//                     ),
//                     Divider(),
//                   ],
//                 ),
//               ],
//             ),
//           );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_instagram_clone/providers/user_provider.dart';
// import 'package:instagram_clone_flutter/resources/firestore_methods.dart';
// import 'package:instagram_clone_flutter/utils/colors.dart';
// import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../providers/users_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colour.dart';
import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FirestoreMethod().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          'Posted!', context,
        );
        clearImage();
      } else {
        showSnackBar(res, context,);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        err.toString(), context
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UsersProvider userProvider = Provider.of<UsersProvider>(context);

    return _file == null
        ? Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
        ),
        onPressed: () => _selectImage(context),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        title: const Text(
          'Post to',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () => postImage(
              userProvider.getUser.uid,
              userProvider.getUser.username,
              userProvider.getUser.photoUrl,
            ),
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      // POST FORM
      body: Column(
        children: <Widget>[
          isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  userProvider.getUser.photoUrl,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                          image: MemoryImage(_file!),
                        )),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

