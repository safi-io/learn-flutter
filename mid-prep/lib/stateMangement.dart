import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RealCounterModel(),
      child: const MaterialApp(home: MyNewPage()),
    ),
  );
}

class MyNewPage extends StatelessWidget {
  const MyNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<RealCounterModel>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("${counter.count}"),
          ElevatedButton(onPressed: counter.increment, child: Text("INC")),
          ElevatedButton(onPressed: counter.decrement, child: Text("DEC")),
        ],
      ),
    );
  }
}

class RealCounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (count == 0) return;
    _count--;
    notifyListeners();
  }
}
