// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.content,
    required this.isUserMessage,
    super.key,
  });

  final String content;
  final bool isUserMessage;
  
  get myP => null;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUserMessage ? myP : Colors.blueAccent[100],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  isUserMessage ? 'You' : 'AI',
                  style: const TextStyle(fontWeight: FontWeight.bold, color:  Color.fromRGBO(217, 217, 217, 1),),
                ),
              ],
            ),
            const SizedBox(height: 8),
            MarkdownWidget(
              data: content,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
  
  MarkdownWidget({required String data, required bool shrinkWrap}) {}
}
