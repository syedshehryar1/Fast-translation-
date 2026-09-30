import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Translation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final input = TextEditingController();
  final output = TextEditingController();
  final translator = GoogleTranslator();
  bool loading = false;

  void translate() async {
    if (input.text.isEmpty) return;
    setState(() => loading = true);
    try {
      final t = await translator.translate(input.text, from: 'en', to: 'ur');
      output.text = t.text;
    } catch (e) {
      output.text = 'Error: $e';
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fast Translation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: input,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Yahan likho',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : translate,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Translate'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: output,
              maxLines: 4,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Result',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
