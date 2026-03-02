import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final List<int> _numbers = [];
  bool _isError = false;

  void _handleInput() {
    setState(() {
      String text = _controller.text;

      if (text == "Avada Kedavra") {
        _numbers.clear();
        _isError = false;
        _controller.clear();
        return;
      }

      int? val = int.tryParse(text);
      if (val != null) {
        _numbers.add(val);
        _isError = false;
        _controller.clear();
      } else {
        _isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var stats = <int, int>{};
    for (var n in _numbers) stats[n] = (stats[n] ?? 0) + 1;
    var sortedEntries = stats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nazarko Stat APP'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Частота чисел', style: TextStyle(fontSize: 20))),
            ...sortedEntries.map((e) => ListTile(
              title: Text('Число ${e.key}'),
              trailing: Text('Повторів: ${e.value}'),
            )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Введіть число',
                errorText: _isError ? 'Це не число!' : null,
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _handleInput(),
            ),
            const SizedBox(height: 20),
            Text('Всього додано: ${_numbers.length}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (ctx) => FloatingActionButton(
        onPressed: () {
          _handleInput();
          Scaffold.of(ctx).openDrawer();
        },
        child: const Icon(Icons.visibility),
      )),
    );
  }
}