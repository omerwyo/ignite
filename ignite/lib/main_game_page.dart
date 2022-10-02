import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              child: const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('Leaderboard'),
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
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: Container(
          width: 200,
          height: 1000,
          child: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                    height: 120.0,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xffFFDF8F),
                      ),
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.all(22.0),
                      child: Text('Menu'),
                    )),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Map'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.leaderboard_rounded),
                  title: const Text('Leaderboard'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Discover'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const CSPage();
                    }));
                  },
                ),
              ],
            ),
          )),
      body: Stack(
          // ignore: sort_child_properties_last
          // color: const Color.fromRGBO(0, 0, 0, 1),
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 300.0,
              height: 80,
              margin: const EdgeInsets.only(top: 200.0, left: 40),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Center(
                child: Text('Leaderboard',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: 300.0,
              height: 450,
              margin: const EdgeInsets.only(top: 330.0, left: 40),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: const Color(0xffFFDF8F).withOpacity(0.8),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: const <Widget>[
                    LeaderBoardBar(hours: 131, index: 1, userName: "Cheryl"),
                    SizedBox(width: 50),
                    LeaderBoardBar(hours: 122, index: 2, userName: "Samuel"),
                    SizedBox(width: 50),
                    LeaderBoardBar(hours: 103, index: 3, userName: "Patrick"),
                    SizedBox(width: 50),
                    LeaderBoardBar(hours: 97, index: 4, userName: "Charlotte"),
                    SizedBox(width: 50),
                    LeaderBoardBar(hours: 92, index: 5, userName: "Sam"),
                    SizedBox(width: 50),
                    LeaderBoardBar(hours: 89, index: 6, userName: "Paisley"),
                    SizedBox(width: 50),
                    LeaderBoardBar(hours: 88, index: 7, userName: "Chloe"),
                    SizedBox(width: 50),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}

class LeaderBoardBar extends StatelessWidget {
  const LeaderBoardBar({
    Key? key,
    required this.hours,
    required this.index,
    required this.userName,
  }) : super(key: key);

  final int hours;
  final int index; // used to assign avatar image
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
        // Calculate width
        width: 285 * (hours / 131),
        height: 45,
        margin: EdgeInsets.only(top: 30.0 + (index - 1) * 70, left: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: const Color(0xff40848F).withOpacity(1),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5.0, left: 7.0),
              width: 35.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/avatar$index.png"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  userName,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            const SizedBox(width: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '- $hours',
                textAlign: TextAlign.right,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
            ),
          ],
        ));
  }
}

class CSPage extends StatefulWidget {
  const CSPage({Key? key}) : super(key: key);

  @override
  CSState createState() => CSState();
}

class CSState extends State<CSPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: Container(
          width: 200,
          height: 1000,
          child: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                    height: 120.0,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xffFFDF8F),
                      ),
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.all(22.0),
                      child: Text('Menu'),
                    )),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Map'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.leaderboard_rounded),
                  title: const Text('Leaderboard'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Discover'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const LogInPage();
                    }));
                  },
                  // onTap: () {
                  //   // Update the state of the app
                  //   // ...
                  //   // Then close the drawer
                  //   Navigator.pop(context);
                  // },
                ),
              ],
            ),
          )),
      body: Stack(
          // ignore: sort_child_properties_last
          // color: const Color.fromRGBO(0, 0, 0, 1),
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 300.0,
              height: 80,
              margin: const EdgeInsets.only(top: 110.0, left: 40),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Center(
                child: Text('        COMMUNITY  \n SERVICE PROJECTS',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: 300.0,
              height: 80,
              margin: const EdgeInsets.only(top: 220.0, right: 220),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                // color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Center(
                child: Text('Filters:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: 100.0,
              height: 30,
              margin: const EdgeInsets.only(top: 245.0, left: 260),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: const Color(0xff40848F),
              ),
              child: const Center(
                child: Text('< Weekly',
                    style:
                        TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,)),
              ),
            ),
            Container(
              width: 100.0,
              height: 30,
              margin: const EdgeInsets.only(top: 245.0, left: 140),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: const Color(0xff40848F),
              ),
              child: const Center(
                child: Text('< Primary',
                    style:
                        TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,)),
              ),
            ),
            Container(
              width: 100.0,
              height: 30,
              margin: const EdgeInsets.only(top: 295.0, left: 50),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: const Color(0xff40848F),
              ),
              child: const Center(
                child: Text('< Tuition',
                    style:
                        TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,)),
              ),
            ),
            Container(
              width: 300.0,
              height: 450,
              margin: const EdgeInsets.only(top: 330.0, left: 40),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: const Color(0xffFFDF8F).withOpacity(0.8),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: const <Widget>[
                    CSBar(hours: 120, index: 1, userName: "Brighton", user: "brighton"),
                    SizedBox(width: 50),
                    CSBar(hours: 122, index: 2, userName: "Bukit Batok", user: "bukit"),
                    SizedBox(width: 50),
                    CSBar(hours: 103, index: 3, userName: "Heartware", user: "sg"),
                    SizedBox(width: 50),
                    // CSBar(hours: 97, index: 4, userName: "Charlotte", user: "brighton"),
                    // SizedBox(width: 50),
                    // CSBar(hours: 92, index: 5, userName: "Sam", user: "brighton"),
                    // SizedBox(width: 50),
                    // CSBar(hours: 89, index: 6, userName: "Paisley", user: "brighton"),
                    // SizedBox(width: 50),
                    // CSBar(hours: 88, index: 7, userName: "Chloe", user: "brighton"),
                    // SizedBox(width: 50),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}

class CSBar extends StatelessWidget {
  const CSBar({
    Key? key,
    required this.hours,
    required this.index,
    required this.userName,
    required this.user,
  }) : super(key: key);

  final int hours;
  final int index; // used to assign avatar image
  final String userName;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Container(
        // Calculate width
        width: 285,
        height: 115,
        // margin: EdgeInsets.only(top: 70.0 + (index - 1) * 70, left: 5, bottom: 500),
        margin: EdgeInsets.only(top:index * 150 - 130, left: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          // color: const Color(0xff40848F).withOpacity(1),
          color: const Color(0xff40848F).withOpacity(1),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5.0, left: 7.0),
              width: 35.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/$user.png"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  userName,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            const SizedBox(width: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '- $hours',
                textAlign: TextAlign.right,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
            ),
          ],
        ));
  }
}

