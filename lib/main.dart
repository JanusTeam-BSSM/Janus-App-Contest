import 'package:flutter/material.dart';
import 'package:janus_app_contest/provider/mqttConnect.dart';

void main() {
  connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('테스트'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('출발점'),
            TextField(
              controller: controller1,
            ),
            const Text('도착점'),
            TextField(
              controller: controller2,
            ),
            ElevatedButton(
                onPressed: () {
                  controller1.text = '';
                  controller2.text = '';
                },
                child: const Text('제출')
            )
          ],
        ),
      ),
    );
  }
}
