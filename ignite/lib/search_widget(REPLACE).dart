import 'package:flutter/material.dart';
import 'contri_side_game.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Center(
        child: const Text(
          'blablabla',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}