// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medappfv/Pages/Social/screens/DownvoteButton.dart';
import 'UpvoteButton.dart';

//store votes, and replies have mysteriously disappeard 

class QuestionDetailScreen extends StatelessWidget {
  final String questionId;

  const QuestionDetailScreen({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: QuestionDetail(questionId: questionId),
            ),
          ),
          AnswerForm(questionId: questionId),
        ],
      ),
    );
  }
}

class QuestionDetail extends StatelessWidget {
  final String questionId;

  const QuestionDetail({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('questions')
          .doc(questionId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        var questionData = snapshot.data?.data() as Map<String, dynamic>;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Question',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        questionData['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    questionData['content'],
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UpvoteButton(questionId: questionId, answerId: ''),
                    DownvoteButton(questionId: questionId, answerId: ''), // Pass empty answerId for question-level downvotes
                    Text(
                      'Votes: ${calculateUpvotes(questionId)}',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
                AnswerList(
                  questionId: questionId,
                  sortBy: 'upvotes', // Sort answers by upvotes
                ),
                ReplyForm(questionId: questionId, answerId: ''), // Pass empty answerId for replies directly to the question
              ],
            ),
          ),
        );
      },
    );
  }
}
// Placeholder function to demonstrate upvote calculation (implement logic here)
int calculateUpvotes(String questionId) {
  // Replace with logic to get upvote count from Firebase
  return 0;
}

class AnswerForm extends StatefulWidget {
  final String questionId;

  const AnswerForm({super.key, required this.questionId});

  @override
  _AnswerFormState createState() => _AnswerFormState();
}

class _AnswerFormState extends State<AnswerForm> {
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Your Answer'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _submitAnswer(widget.questionId, _answerController.text);
              },
              child: const Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitAnswer(String questionId, String answerContent) {
    FirebaseFirestore.instance
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .add({
      'content': answerContent,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': FirebaseAuth.instance.currentUser?.uid,
    });
    _answerController.clear();
  }
}

class AnswerList extends StatelessWidget {
  final String questionId;
  final String sortBy;

  const AnswerList({super.key, required this.questionId, required this.sortBy});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('questions')
          .doc(questionId)
          .collection('answers')
          .orderBy(sortBy, descending: true) // Sort based on 'sortBy'
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        var answers = snapshot.data?.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: answers?.length,
          itemBuilder: (context, index) {
            var answerData = answers?[index].data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text(
                      'Answer', // Placeholder for displaying user info
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    subtitle: Text(
                      answerData['content'],
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UpvoteButton(answerId: answers![index].id, questionId: questionId,),
                      DownvoteButton(answerId: answers[index].id, questionId: questionId,),
                      Text(
                        'Votes: ${calculateUpvotes(answers[index].id)}', // Pass answerId for upvote calculation
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      IconButton(
                        icon: const Icon(Icons.reply),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReplyForm(
                                questionId: questionId,
                                answerId: answers[index].id,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  _buildReplyTree(answerData['replies'], 0), // Display existing replies
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReplyTree(List<dynamic>? replies, int level) {
    if (replies == null || replies.isEmpty) {
      return Container(); // No replies, return an empty container
    }

    return Column(
      children: replies.map((reply) {
        var replyData = reply.data() as Map<String, dynamic>;

        return Card(
          margin:
              EdgeInsets.only(left: level * 16.0, right: 10, top: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User ID: ${replyData['userId']}',
                  style: const TextStyle(fontSize: 12, color: Colors.black)),
              ListTile(
                title: Text(replyData['content'],
                    style: const TextStyle(fontSize: 18, color: Colors.black)),
              ),
              _buildReplyTree(replyData['replies'],
                  level + 1), // Recursive call for nested replies
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ReplyForm extends StatefulWidget {
  final String answerId;
  final String questionId;
  final String? parentReplyId;

  const ReplyForm(
      {super.key, required this.answerId, required this.questionId, this.parentReplyId});

  @override
  _ReplyFormState createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {
  final TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _replyController,
              decoration: const InputDecoration(labelText: 'Your Reply'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                User? user = await _getCurrentUser();
                if (user != null) {
                  final userId = user.uid;
                  _submitReply(widget.answerId, widget.questionId,
                      _replyController.text, userId);
                }
              },
              child: const Text('Submit Reply'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReply(
      String answerId, String questionId, String replyContent, String userId) {
    FirebaseFirestore.instance
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(answerId)
        .collection('replies')
        .add({
      'content': replyContent,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
      'parentReplyId': widget.parentReplyId,
    });

    _replyController.clear();
  }

  Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
