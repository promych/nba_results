import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/scoreboard_bloc.dart';
import './blocs/scoreboard_events.dart';
import './blocs/standings_bloc.dart';
import './blocs/standings_events.dart';
import './repositories/scoreboard.dart';
import './screens/results.dart';
import './screens/standings.dart';
import './ui/date_picker.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  int _navIndex = 0;
  List<Widget> _pages = [];
  AnimationController _switchController;
  ScoreboardBloc _scoreboardBloc;
  StandingsBloc _standingsBloc;

  @override
  void initState() {
    super.initState();
    _pages = [ResultsPage(), StandingsPage()];

    _scoreboardBloc = ScoreboardBloc(scoreboard: Scoreboard());
    _standingsBloc = StandingsBloc();
    _scoreboardBloc.dispatch(FetchGames());
    _standingsBloc.dispatch(FetchStandings());

    _switchController =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
  }

  @override
  void dispose() {
    _scoreboardBloc?.dispose();
    _standingsBloc?.dispose();
    _switchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScoreboardBloc>(builder: (_) => _scoreboardBloc),
        BlocProvider<StandingsBloc>(builder: (_) => _standingsBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('NBA Results'),
            backgroundColor: Colors.grey[800],
            elevation: 0.0,
            leading: DatePicker(),
            actions: [
              IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.list_view,
                  progress: _switchController,
                ),
                onPressed: () {
                  if (_navIndex == 0) {
                    _switchController.forward();
                    setState(() {
                      _navIndex = 1;
                    });
                  } else {
                    _switchController.reverse();
                    setState(() {
                      _navIndex = 0;
                    });
                  }
                },
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1),
                    BlendMode.dstATop,
                  ),
                  image: AssetImage('assets/ball.jpg'),
                ),
              ),
              child: Center(child: _pages.elementAt(_navIndex)),
            ),
          ),
        ),
      ),
    );
  }
}
