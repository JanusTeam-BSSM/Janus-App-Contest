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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('hello'),
        ),
        body: const Center(
          child: Text('Hello World!!!!'),
        ),
      ),
    );
  }
}
