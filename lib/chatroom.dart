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

  // 사용자가 입력한 값을 저장하는 변수
  String textContent = "";

  late final GenerativeModel _model;
  late final ChatSession _chateSession;

  // 중요한 데이터 숨기기
  static const String _apiKey = String.fromEnvironment("API_KEY");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_apiKey);

    _model = GenerativeModel(
        model: "gemini-1.5-flash-latest",
        apiKey: _apiKey); // api key 값 세팅 및 , gemini 모델 선택
    _chateSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              // 해당 정보는 gemini 의 값을 받아오는데 데이터 형식이 많기 때문에 일단 text 만 가지고와서 채워주기
              final content = _chateSession.history.toList()[index];
              final text = content.parts
                  .whereType<TextPart>()
                  .map(
                    (e) => e.text,
                  )
                  .join();

              return ListTile(
                title: MessageWidget(
                  message: text,
                  isUserMessage: content.role == 'user',
                ),
              );
            }),
            itemCount: _chateSession.history.length,
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
                // 한글 처리를 하기 위해서 onChange 를 사용해서 String 에 사용자 값을 저장 시키면서 처리해야한다.
                onChanged: (value) {
                  setState(
                    () => textContent = textController.text,
                  );
                },
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

    // 직접적으로 gemini에 값 던지기
    final response = await _chateSession.sendMessage(Content.text(value));

    setState(() {
      isLoding = false;
    });

    _scrollToBottom();
    _focusNode.requestFocus();
  }
}
