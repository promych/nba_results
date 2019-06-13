import 'package:flutter/material.dart';
import 'package:nba_results/screens/screens.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int navIndex = 0;
  final pages = <Widget>[
    ResultsPage(),
    StandingsPage(),
  ];
  final DateTime dateToday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('NBA Results'),
          backgroundColor: Colors.grey[800],
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.1), BlendMode.dstATop),
                    image: AssetImage('assets/ball.jpg'))),
            child: Center(
              child: pages.elementAt(navIndex),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.score),
              title: Text('Results'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text('Standings'),
            )
          ],
          currentIndex: navIndex,
          onTap: (int index) {
            setState(() {
              navIndex = index;
            });
          },
        ),
      ),
    );
  }
}
