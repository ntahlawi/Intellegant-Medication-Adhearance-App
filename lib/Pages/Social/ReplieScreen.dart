import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/TextBtn.dart';

class QuestionDetailScreen extends StatelessWidget {
  final String questionId;

  QuestionDetailScreen({required this.questionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: QuestionDetail(questionId: questionId),
          ),
          CommentInput(questionId: questionId),
        ],
      ),
    );
  }
}

class QuestionDetail extends StatelessWidget {
  final String questionId;

  QuestionDetail({required this.questionId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('questions').doc(questionId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        var questionData = snapshot.data!.data() as Map<String, dynamic>;

        return SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionData['title'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                questionData['content'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Comments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              CommentList(questionId: questionId),
            ],
          ),
        );
      },
    );
  }
}

class CommentList extends StatelessWidget {
  final String questionId;

  CommentList({required this.questionId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('questions').doc(questionId).collection('comments').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        var commentDocs = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: commentDocs.length,
          itemBuilder: (context, index) {
            var commentData = commentDocs[index].data() as Map<String, dynamic>;
            return CommentItem(commentData: commentData);
          },
        );
      },
    );
  }
}

class CommentItem extends StatelessWidget {
  final Map<String, dynamic> commentData;

  CommentItem({required this.commentData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            commentData['comment'],
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            'By: ${commentData['user']}',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class CommentInput extends StatefulWidget {
  final String questionId;

  CommentInput({required this.questionId});

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _commentController = TextEditingController();

  void _postComment() {
    String comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      FirebaseFirestore.instance.collection('questions').doc(widget.questionId).collection('comments').add({
        'comment': comment,
        'user': 'User', // You can replace 'User' with the name of the logged-in user
        'timestamp': Timestamp.now(),
      }).then((value) {
        _commentController.clear();
      }).catchError((error) {
        print('Error posting comment: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: _postComment,
            child: Text('Post'),
          ),
        ],
      ),
    );
  }
}
