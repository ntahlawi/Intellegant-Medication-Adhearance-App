import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    required this.content,
    required this.isUserMessage,
    super.key,
  });

  final String content;
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
            Row(
              children: [
                Icon(
                  widget.isUserMessage
                      ? EvaIcons.person
                      : EvaIcons.messageCircle,
                ),
              ],
            ),
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
