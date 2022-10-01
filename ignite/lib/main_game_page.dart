import 'package:flutter/material.dart';
import 'helpers/direction.dart';
import 'helpers/joypad.dart';
import 'package:flame/game.dart';
import 'contri_side_game.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  ContriSideGame game = ContriSideGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(game: game),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LogInPage();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: const Text('Next'),
              ),
            ),
          ],
        ));
  }

  void onJoypadDirectionChanged(Direction direction) {
    game.onJoypadDirectionChanged(direction);
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Map'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Leaderboard'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Search'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // body: Container(
      //   // ignore: sort_child_properties_last
      //   // color: const Color.fromRGBO(0, 0, 0, 1),
      //   child: Center(
      //     // fit: BoxFit.fitWidth, 
      //     child: Text('Leaderboard'),
      //     heightFactor: 190.0,
      //     widthFactor: MediaQuery.of(context).size.width - 100.0,
      //   ),
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/images/background.png"),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),


      body: Stack(
        // ignore: sort_child_properties_last
        // color: const Color.fromRGBO(0, 0, 0, 1),
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text('Leaderboard',
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold)),
            ),
            width: 300.0,
            height: 80,
            margin: const EdgeInsets.only(top: 200.0, left: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Container(
            child: Center(
              child: Text('',
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold)),
            ),
            width: 300.0,
            height: 450,
            margin: const EdgeInsets.only(top: 330.0, left: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Color(0xffFFDF8F).withOpacity(0.8),
            ),
          ),
          Container(
            child: Center(
              child: Text('        Cheryl              |   112',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
            ),
            width: 270.0,
            height: 45,
            margin: const EdgeInsets.only(top: 377.0, left: 56),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Color(0xff40848F).withOpacity(1),
            ),
          ),
          Container(
            child: Center(
              child: Text('       Samuel        |   110',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
            ),
            width: 250.0,
            height: 45,
            margin: const EdgeInsets.only(top: 447.0, left: 56),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Color(0xff40848F).withOpacity(1),
            ),
          ),
          Container(
            child: Center(
              child: Text('        Patrick      |   105',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
            ),
            width: 235.0,
            height: 45,
            margin: const EdgeInsets.only(top: 517.0, left: 56),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Color(0xff40848F).withOpacity(1),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 45.0, left: 70.0),
            width: 35.0,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/avatar1.png"),
            ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 95.0, left: 70.0),
            width: 35.0,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/avatar2.png"),
            ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 235.0, left: 70.0),
            width: 35.0,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/avatar3.png"),
            ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 375.0, left: 70.0),
            width: 35.0,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/avatar4.png"),
            ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 375.0, left: 70.0),
            width: 35.0,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/avatar5.png"),
            ),
            ),
          ),
        ]
      ),
    );
  }
}
