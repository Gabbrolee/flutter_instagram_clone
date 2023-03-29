import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/global_variables.dart';
import 'package:flutter_instagram_clone/providers/users_provider.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
   addData();
    super.initState();
  }

  addData()async{
    UsersProvider usersProvider = Provider.of(context, listen: false);
    await usersProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth > webScreenSize) {
        // web screen
        return widget.webScreenLayout;
      }
      // mobile screen
      return widget.mobileScreenLayout;
    });
  }
}
