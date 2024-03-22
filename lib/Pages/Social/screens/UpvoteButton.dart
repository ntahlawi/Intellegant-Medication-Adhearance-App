// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UpvoteButton extends StatefulWidget {
  final String questionId;

  const UpvoteButton({super.key, required this.questionId, required String answerId});

  @override
  // ignore: library_private_types_in_public_api
  _UpvoteButtonState createState() => _UpvoteButtonState();
}

class _UpvoteButtonState extends State<UpvoteButton> {
  bool _hasUpvoted = false; // Track upvote state

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_hasUpvoted ? Icons.arrow_upward_rounded : Icons.arrow_upward_outlined),
      onPressed: () async {
        // Update upvote status in Firebase
        _hasUpvoted = !_hasUpvoted;
        // Implement upvote logic here (e.g., update upvote count)
      },
      color: Colors.blue,
    );
  }
}
