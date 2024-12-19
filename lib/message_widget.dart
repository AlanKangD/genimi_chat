import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.isUserMessage, required this.message});

  final bool isUserMessage;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          // 만약 container 영역이 폭을 넘어 선다면 width 값을 주고 하단의 코드를 넣어주면 된다.
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: isUserMessage
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: MarkdownBody(
            data: message,
            selectable: true,
          ),
        ),
      ],
    );
  }
}
