import 'package:chat_project/chatroom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
