import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'main_game_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ContriSide',
      home: MainGamePage(),
      // login: LogInPage()
    );
  }
}

class LogInPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return const Container(
      // debugShowCheckedModeBanner: false,
      title: 'LogIn',
      alignment: Alignment.center,
      home: Text('Log In Page'),
      // home: LogInPage()
    );
  }
}
