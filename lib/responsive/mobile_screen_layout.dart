import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/global_variables.dart';
import 'package:flutter_instagram_clone/utils/colour.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _index = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
   pageController.dispose();
    super.dispose();
  }

  void navigationTab(int index){
   pageController.jumpToPage(index);
  }
  void onPageChange(int index){
    setState(() {
      _index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
       physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChange,
       children:  homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
         backgroundColor: mobileBackgroundColor,
        items:  [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: _index == 0 ? primaryColor : secondaryColor,), backgroundColor: primaryColor, label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: _index == 1 ? primaryColor : secondaryColor,), backgroundColor: primaryColor, label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, color: _index == 2 ? primaryColor : secondaryColor), backgroundColor: primaryColor, label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: _index == 3 ? primaryColor : secondaryColor), backgroundColor: primaryColor, label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: _index == 4 ? primaryColor : secondaryColor), backgroundColor: primaryColor, label: ""),
        ],
        onTap: navigationTab,
      ),
    );
  }
}
