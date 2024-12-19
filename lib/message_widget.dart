import 'package:flutter/material.dart';

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
          decoration: BoxDecoration(
            color: isUserMessage ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(message)),
      ],
    );
  }
}
