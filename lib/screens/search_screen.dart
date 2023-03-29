import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colour.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            label: Text("Search for a user"),
          ),
          onFieldSubmitted: (String _) {
           setState(() {
             isShowUsers = true;
           });
          },
        ),
      ),
      body: isShowUsers ? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('username', isGreaterThanOrEqualTo: searchController.text)
            .get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
         return ListView.builder(
             itemCount: snapshot.data!.docs.length,
             itemBuilder: (context,index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    snapshot.data!.docs[index]['photoUrl']
                  ),
                ),
                title: Text(snapshot.data! .docs[index]['username']),
              );
         });
        },
      ) : FutureBuilder(
        future: FirebaseFirestore.instance.collection('posts').get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          return GridView.builder(
            itemCount: snapshot.data!.docs.length ,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 3
            ),
            itemBuilder: (BuildContext context, int index)=>
                Image.network(snapshot.data!.docs[index]['postUrl']),
          );
        },
      ),
    );
  }
}


