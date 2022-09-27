import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late SocketIO socketIO; // 실제 socket을 받을 수 있는 란
  late List<String> messages;
  late double height, width;
  late TextEditingController textEditingController;
  late ScrollController scrollController;

  @override
  void initState() {
    // Initializing the message list
    messages = [];

    textEditingController = TextEditingController();
    scrollController = ScrollController();

    socketIO =
        SocketIOManager().createSocketIO("http://JanusTeam.iptime.org", '/');

    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      //https://medium.com/flutter-community/realtime-chat-app-flutter-node-js-socket-io-e298cd27fb06
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
