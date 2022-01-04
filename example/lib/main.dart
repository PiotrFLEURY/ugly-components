import 'package:flutter/material.dart';
import 'package:uglycomponents/uglycomponents.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ugly components',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Multiggle(
                  count: 2,
                  backgroundColor: Colors.green.withAlpha(200),
                  borderColor: Colors.green,
                  indicatorColor: Colors.teal,
                  onPositionChanged: (position) {
                    debugPrint('Multiggle position changed to $position');
                  },
                ),
              ),
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
              ExclusiveRadioGroup(
                alignment: ExclusiveRadioGroupAlignment.vertical,
                children: [
                  ExclusiveRadio(
                    index: 0,
                    text: 'AAAAAAAAAAAAAAAA',
                  ),
                  ExclusiveRadio(
                    index: 1,
                    text: 'BBBBBBBBBBBBBBBB',
                  ),
                  ExclusiveRadio(
                    index: 2,
                    text: 'CCCCCCCCCCCCCCC',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
