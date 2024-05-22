import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostQuestionScreen extends StatefulWidget {
  @override
  _PostQuestionScreenState createState() => _PostQuestionScreenState();
}

class _PostQuestionScreenState extends State<PostQuestionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  String _selectedGroup = 'General';

void _postQuestion() async {
  if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
    FirebaseFirestore.instance.collection('Questions').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'group': _selectedGroup,
      'timestamp': FieldValue.serverTimestamp(), // Store the creation time of the question.
    }).then((value) => print('Question Posted'))
    .catchError((error) => print('Failed to add question: $error'));

    _titleController.clear();
    _descriptionController.clear();
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill in all fields'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              focusNode: _titleFocus,
              controller: _titleController,
              onTap: () => FocusScope.of(context).requestFocus(_titleFocus),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 8),
            TextField(
              focusNode: _descriptionFocus,
              controller: _descriptionController,
              onTap: () => FocusScope.of(context).requestFocus(_descriptionFocus),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              maxLines: 4,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedGroup,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGroup = newValue!;
                });
              },
              items: <String>['Diabetic', 'Pre-Diabetic', 'General']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _postQuestion,
              child: Text('Post Question'),
            ),
          ],
        ),
      ),
    );
  }
}
