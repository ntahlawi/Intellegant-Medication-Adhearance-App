// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medappfv/Pages/Social/screens/Replies.dart';

class QuestionListScreen extends StatelessWidget {
  const QuestionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Questions'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const AllQuestionsList(),
    );
  }
}

class AllQuestionsList extends StatelessWidget {
  const AllQuestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('questions').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        var questions = snapshot.data?.docs;
        return ListView.builder(
          itemCount: questions?.length,
          itemBuilder: (context, index) {
            var question = questions?[index].data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(question['title']),
                subtitle: Text(question['content']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionDetailScreen(questionId: questions![index].id),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

