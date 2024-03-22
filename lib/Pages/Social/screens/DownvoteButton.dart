// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class DownvoteButton extends StatefulWidget {
  final String answerId;

  const DownvoteButton({super.key, required this.answerId, required String questionId});

  @override
  _DownvoteButtonState createState() => _DownvoteButtonState();
}

class _DownvoteButtonState extends State<DownvoteButton> {
  bool _hasDownvoted = false; // Track downvote state

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_hasDownvoted ? Icons.arrow_downward_rounded : Icons.arrow_downward_outlined),
      onPressed: () async {
        // Update downvote status in Firebase
        _hasDownvoted = !_hasDownvoted;
        // Implement downvote logic here (e.g., update downvote count)
        // ... (replace with your downvote logic using answerId from widget)
      },
      color: Colors.red,
    );
  }
}
