import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../providers/users_provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePics']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: widget.snap['name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " ${widget.snap['text']}",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      // "23/12/21",
                      DateFormat.yMMMEd()
                          .add_Hm()
                          .format(widget.snap['datePublished'].toDate()),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.favorite_border,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
