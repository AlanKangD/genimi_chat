import 'package:chat_project/chatroom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // safeArea 를 설정하면 위 아래의 안전영역을 설정하여 프레임을 넘어서는것을 방지할 수 있다.
    return SafeArea(
      // minimum: const EdgeInsets.only(
      //   top: 20, // 상단 여백
      //   bottom: 20, // 하단 여백
      //   left: 16, // 왼쪽 여백
      //   right: 16, // 오른쪽 여백
      // ),
      child: MaterialApp(
        // 상단 debug 표시 삭제 or 표시ㄱ
        // debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorSchemeSeed: const Color.fromARGB(255, 0, 255, 255),
            brightness: Brightness.dark),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Genimi"),
          ),
          body: const Center(
            child: Chatroom(),
          ),
        ),
      ),
    );
  }
}
