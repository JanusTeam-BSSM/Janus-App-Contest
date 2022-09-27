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
  late TextEditingController textController;
  late ScrollController scrollController;

  @override
  void initState() {
    // Initializing the message list
    messages = [];

    textController = TextEditingController();
    scrollController = ScrollController();

    socketIO =
        SocketIOManager().createSocketIO("http://JanusTeam.iptime.org", '/');

    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      //https://medium.com/flutter-community/realtime-chat-app-flutter-node-js-socket-io-e298cd27fb06
      setState(
        () => messages.add(data['message'])
      );
      scrollController.animateTo(
	      scrollController.position.maxScrollExtent,
	      duration: Duration(milliseconds: 600),
	      curve: Curves.ease,
      );
    });

    // Connect to the socket
    socketIO.connect();
    super.initState();
  }

  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
	      padding: const EdgeInsets.all(20.0),
	      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return SizedBox(
      height: height * 0.8,
      width: width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: const InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      onPressed: () {
        if(textController.text.isNotEmpty) {
          socketIO.sendMessage('send_message', json.encode({'message': textController.text}));
          setState(() => {
            messages.add(textController.text)
          });
          textController.text = '';

          scrollController.animateTo(
            scrollController.position.maxScrollExtent, 
            duration: const Duration(milliseconds: 600),
            curve: Curves.ease
          );
        }
      },
      child: const Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }
}
