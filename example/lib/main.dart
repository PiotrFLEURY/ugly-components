import 'package:flutter/material.dart';
import 'package:uglycomponents/troggle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int quarterTurns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Troggle(
              width: 100,
              height: 100,
              quarterTurns: quarterTurns,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (quarterTurns == 3) {
                    quarterTurns = 0;
                  } else {
                    quarterTurns++;
                  }
                });
              },
              child: const Text('Turn'),
            ),
          ],
        ),
      ),
    );
  }
}
