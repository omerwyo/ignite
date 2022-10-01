import 'package:flutter/material.dart';
import 'helpers/direction.dart';
import 'helpers/joypad.dart';
import 'package:flame/game.dart';
import 'contri_side_game.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<LogInPage> {
  // ContriSideGame game = ContriSideGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            // GameWidget(game: game),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                // child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
              ),
            )
          ],
        ));
  }

  // void onJoypadDirectionChanged(Direction direction) {
  //   game.onJoypadDirectionChanged(direction);
  // }
}
