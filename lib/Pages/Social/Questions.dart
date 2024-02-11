import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostQuestionScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Question'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _postQuestion(context);
              },
              child: Text('Post Question'),
            ),
          ],
        ),
      ),
    );
  }

  void _postQuestion(BuildContext context) async {
    var title = _titleController.text;
    var content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('questions').add({
          'title': title,
          'content': content,
          'timestamp': FieldValue.serverTimestamp(),
          'userId': user.uid,
        });

        Navigator.pop(context);
      } else {
        // Handle the case where the user is not signed in
        print('User is not signed in');
      }
    }
  }
}
