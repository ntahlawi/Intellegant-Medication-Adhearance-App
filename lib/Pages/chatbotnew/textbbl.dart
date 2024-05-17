// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown.dart';

import '../../components/Themes/Sizing.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    required this.content,
    required this.isUserMessage,
    super.key,
  });

  final content;
  final bool isUserMessage;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final themeData = Theme.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.95),
      margin: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
      decoration: BoxDecoration(
        color: widget.isUserMessage
            ? themeData.colorScheme.secondary
            : themeData.colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.pointFifteenHeight),
            MarkdownWidget(
              data: widget.content,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
