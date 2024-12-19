import 'package:chat_project/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  List<String> chatbotHistory = [
    'Hi there!',
    'How cna I help you?',
    'Sure I can help with that!',
    'Here is the information you requested',
    'Hi there!',
    'How can I assist tou todey',
    'Sure I can help with that!',
    'Here is the information you requested',
    'Hi there!',
  ];

  final TextEditingController textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool isLoding = false;

  late final GenerativeModel _model;
  late final ChatSession _chateSession;

  // 중요한 데이터 숨기기
  static const String _apiKey = String.fromEnvironment("API_KEY");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_apiKey);

    // _model = GenerativeModel(model: "gemini-pro", apiKey: _apiKey); // api key 값 세팅 및 , gemini 모델 선택
    // _chateSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return ListTile(
                title: MessageWidget(
                  message: chatbotHistory[index],
                  isUserMessage: index % 2 == 1,
                ),
              );
            }),
            itemCount: chatbotHistory.length,
            controller: _scrollController,
          ),
        ),
        if (isLoding) const LinearProgressIndicator(),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                focusNode: _focusNode,
                onSubmitted: (value) {
                  if (!isLoding) {
                    _sendMessage(value);
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type a message',
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.send),
                onPressed: isLoding
                    ? null
                    : () {
                        if (!isLoding) {
                          _sendMessage(textController.text);
                        }
                      }),
          ],
        ),
      ],
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCirc,
      );
    });
  }

  Future _sendMessage(String value) async {
    if (value.isEmpty) {
      return;
    }

    setState(() {
      isLoding = true;
      chatbotHistory.add(value);
      textController.clear();
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoding = false;
        chatbotHistory.add('I am chatbot');
      });
      _scrollToBottom();
      _focusNode.requestFocus();
    });
  }
}
