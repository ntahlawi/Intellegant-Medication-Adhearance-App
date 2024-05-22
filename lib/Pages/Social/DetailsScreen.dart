import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailScreen extends StatefulWidget {
  final String questionId;

  DetailScreen({required this.questionId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _replyController = TextEditingController();

  void _postReply() {
    if (_replyController.text.isNotEmpty) {
      Map<String, dynamic> newReply = {
        'reply': _replyController.text,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'replies': []
      };

      FirebaseFirestore.instance.collection('Questions').doc(widget.questionId)
        .update({
          'replies': FieldValue.arrayUnion([newReply])
        })
        .then((value) => print('Reply added successfully'))
        .catchError((error) => print('Failed to add reply: $error'));
      _replyController.clear();
    } else {
      print('Reply text is empty');
    }
  }

  void _postNestedReply(String replyPath, String text) {
  if (text.isNotEmpty) {
    final DocumentReference questionRef = FirebaseFirestore.instance.collection('Questions').doc(widget.questionId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(questionRef);
      if (!snapshot.exists) {
        throw Exception("Question does not exist!");
      }
      var questionData = snapshot.data() as Map<String, dynamic>;
      var replies = questionData['replies'] as List<dynamic> ?? [];
      
      // Navigate down the reply path to find the correct list to update
      List<dynamic> currentLevel = replies;
      List<String> pathParts = replyPath.split('.');
      for (var i = 1; i < pathParts.length; i += 2) { // Iterate over every second element which should be an index
        int index = int.tryParse(pathParts[i]) ?? -1;
        if (index >= 0 && index < currentLevel.length) {
          var currentReply = currentLevel[index] as Map<String, dynamic>;
          currentLevel = currentReply['replies'] as List<dynamic>;
        } else {
          throw Exception("Reply path is invalid!");
        }
      }

      Map<String, dynamic> nestedReply = {
        'reply': text,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'replies': []
      };

      currentLevel.add(nestedReply);
      transaction.update(questionRef, {'replies': replies});
    }).then((value) => print('Nested reply added successfully'))
      .catchError((error) => print('Failed to add nested reply: $error'));
  } else {
    print('Nested reply text is empty');
  }
}

  void _promptNestedReply(String replyPath) {
    TextEditingController _nestedReplyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Write a reply'),
          content: TextField(
            controller: _nestedReplyController,
            decoration: InputDecoration(hintText: "Reply here..."),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _postNestedReply(replyPath, _nestedReplyController.text);
              },
              child: Text('Send'),
            )
          ],
        );
      }
    );
  }

  Widget _buildReplyTile(Map<String, dynamic> reply, String replyPath) {
    List<dynamic> nestedReplies = []; // Default to an empty list

    if (reply.containsKey('replies') && reply['replies'] is List) {
      nestedReplies = List.from(reply['replies']);
    }

    return ExpansionTile(
      title: Text(reply['reply']),
      subtitle: Text((reply['timestamp'] as Timestamp).toDate().toString()),
      children: nestedReplies.map<Widget>((nestedReply) {
        if (nestedReply is Map<String, dynamic>) {
          String nestedReplyPath = '$replyPath.replies.${nestedReplies.indexOf(nestedReply)}';
          return _buildReplyTile(nestedReply, nestedReplyPath);
        } else {
          return ListTile(title: Text('Incorrect data format in nested replies'));
        }
      }).toList(),
      trailing: IconButton(
        icon: Icon(Icons.reply),
        onPressed: () => _promptNestedReply(replyPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('Questions').doc(widget.questionId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['title']),
                    subtitle: Text(data['description']),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading question');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _replyController,
                decoration: InputDecoration(
                  labelText: 'Write a reply...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _postReply,
                  ),
                ),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
  stream: FirebaseFirestore.instance.collection('Questions').doc(widget.questionId).snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    var data = snapshot.data!.data() as Map<String, dynamic>?;
    var replies = [];
    if (data != null && data.containsKey('replies') && data['replies'] is List) {
      replies = List.from(data['replies']);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: replies.length,
      itemBuilder: (context, index) {
        String replyPath = 'replies.$index';
        return _buildReplyTile(replies[index] as Map<String, dynamic>, replyPath);
      },
    );
  },
)

          ],
        ),
      ),
    );
  }
}
