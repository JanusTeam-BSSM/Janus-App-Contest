import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io('http://JanusServer.ipdisk.co.kr:3000', <String, dynamic> {
    'transports': ['websocket']
});

emit() {
  socket.on('connect', (_) {
    print('connect');
    print(socket.io.engine!.id);
    socket.emit('join', {'name': 'flutter', 'room': 'room1'});
  });
}
class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('hello'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                emit();
              },
              child: const Text('edit')
            )
          ],
        )
      ),
    );
  }
}