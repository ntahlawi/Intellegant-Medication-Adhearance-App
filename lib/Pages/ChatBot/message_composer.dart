import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MessageComposer extends StatelessWidget {
  MessageComposer({
    required this.onSubmitted,
    required this.awaitingResponse,
    Key? key,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  final void Function(String) onSubmitted;
  final bool awaitingResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: !awaitingResponse
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Input field background color
                      ),
                      child: TextField(
                        style: Theme.of(context).textTheme.headlineSmall,
                        cursorColor:
                            Theme.of(context).textTheme.headlineSmall?.color,
                        controller: _messageController,
                        onSubmitted: onSubmitted,
                        decoration: InputDecoration(
                          hintText: 'Write Your Question Here...',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .color,
                              fontSize: 14),
                          prefixIcon: Icon(EvaIcons.search),
                          prefixIconColor: Theme.of(context).iconTheme.color,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Getting An Answer Right Away'),
                        ),
                      ],
                    ),
            ),
            IconButton(
              onPressed: !awaitingResponse
                  ? () => onSubmitted(_messageController.text)
                  : null,
              icon: Icon(
                Icons.send,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
