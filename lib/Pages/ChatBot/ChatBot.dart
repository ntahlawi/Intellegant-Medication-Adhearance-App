// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'chat_api.dart';
import 'chat_page.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({required this.chatApi, super.key});

  final ChatApi chatApi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT Client',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: ChatPage(chatApi: chatApi),
    );
  }
}
