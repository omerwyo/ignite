import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpers/direction.dart';
import 'helpers/joypad.dart';
import 'package:flame/game.dart';
import 'contri_side_game.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Components
class CSBar extends StatelessWidget {
  const CSBar({
    Key? key,
    required this.description,
    required this.duration,
    required this.subduration,
    required this.name,
    required this.index,
    required this.org,
  }) : super(key: key);

  final String description;
  final String duration;
  final String subduration;
  final String name;
  final String org;
  final int index; // used to assign avatar image

  @override
  Widget build(BuildContext context) {
    return Container(
        // Calculate width
        width: 285,
        height: 45,
        margin: EdgeInsets.only(top: 30.0 + (index - 1) * 70, left: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: const Color(0xff40848F).withOpacity(1),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProjectPage();
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 5.0, left: 7.0),
                width: 35.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/$org.png"),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
          ],
        ));
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

// MainMap page
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
              child: Container(
                // padding: EdgeInsets.only(left: 16.0, top: 38.0),
                width: 110.0,
                height: 45,
                margin: const EdgeInsets.only(left: 14.0, top: 38.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  color: const Color(0xffFFDF8F).withOpacity(0.8),
                ),
                child: const Center(
                    child: Text(
                  'Leaderboard',
                  style: TextStyle(fontSize: 15, color: Colors.teal),
                )),
              ),
            ),
          ],
        ));
  }

  void onJoypadDirectionChanged(Direction direction) {
    game.onJoypadDirectionChanged(direction);
  }
}

// Map Page
class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  ProjectPageState createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> {
  @override
  void initState() {
    super.initState();
  }

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(1.3126358495673822, 103.86288002621036);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Trishaw - ENCSS',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Color(0xffFFDF8F).withOpacity(1),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 19.0,
          ),
        ),
      ),
    );
  }
}

// Leaderboard Page
class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<LogInPage> {
  late Response response;
  Dio dio = Dio();

  bool loading = false; //for data fetching status
  // ignore: prefer_typing_uninitialized_variables
  var apidata; //for decoded JSON data
  int count = 0;

  @override
  void initState() {
    getData(); //fetching data
    count = 0;
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    Response response = await dio.get('http://3.15.138.42/user');
    apidata = response.data; //get JSON decoded data from response
    loading = false;
    setState(() {}); //refresh UI
  }

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
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MainGamePage();
                    }));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.leaderboard_rounded),
                  title: const Text('Leaderboard'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Discover'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
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
              child: loading
                  ? const CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: Stack(
                        children: apidata.map<Widget>((user) {
                          count = (count % 7) + 1;
                          return Stack(children: [
                            LeaderBoardBar(
                                hours: user['hours'],
                                index: count,
                                userName: user['firstName']),
                            const SizedBox(width: 50)
                          ]);
                        }).toList(),
                      ),
                    ),
            ),
          ]),
    );
  }
}

// Community Service Projects page
class CSPage extends StatefulWidget {
  const CSPage({Key? key}) : super(key: key);

  @override
  CSState createState() => CSState();
}

class CSState extends State<CSPage> {
  late Response response;
  Dio dio = Dio();

  bool loading = false; //for data fetching status
  // ignore: prefer_typing_uninitialized_variables
  var apidata; //for decoded JSON data
  int count = 0;

  @override
  void initState() {
    getData(); //fetching data
    count = 0;
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    Response response = await dio.get('http://3.15.138.42/proj');
    apidata = response.data; //get JSON decoded data from response
    loading = false;
    setState(() {}); //refresh UI
  }

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
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MainGamePage();
                    }));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.leaderboard_rounded),
                  title: const Text('Leaderboard'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LogInPage();
                    }));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Discover'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )),
      body: Stack(children: [
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
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
          child: loading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Stack(
                    children: apidata.map<Widget>((project) {
                      count = (count % 17) + 1;
                      return Stack(children: [
                        CSBar(
                            description: project['description'],
                            duration: project['duration'],
                            subduration: project['subduration'],
                            index: count,
                            org: project['org'],
                            name: project['name']),
                        const SizedBox(width: 50)
                      ]);
                    }).toList(),
                  ),
                ),
        ),
      ]),
    );
  }
}
