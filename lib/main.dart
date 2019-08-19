import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './repositories/constants.dart';
import './blocs/scoreboard_bloc.dart';
import './blocs/scoreboard_events.dart';
import './blocs/standings_bloc.dart';
import './blocs/standings_events.dart';
import './repositories/scoreboard.dart';
import './screens/results.dart';
import './screens/standings.dart';
import './ui/date_picker.dart';
import './ui/decorated_container.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  int _navIndex = 0;
  List<Widget> _pages = [];
  ScoreboardBloc _scoreboardBloc;
  StandingsBloc _standingsBloc;
  AnimationController _switchController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _scoreboardBloc = ScoreboardBloc(scoreboard: Scoreboard());
    _standingsBloc = StandingsBloc();
    _scoreboardBloc.dispatch(FetchGames());
    _standingsBloc.dispatch(FetchStandings());

    _switchController =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    _pages = [
      ResultsPage(),
      StandingsPage(tabController: _tabController),
    ];
  }

  @override
  void dispose() {
    _scoreboardBloc?.dispose();
    _standingsBloc?.dispose();
    _switchController?.dispose();
    _tabController?.dispose();
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
            bottom: _navIndex == 1
                ? TabBar(
                    controller: _tabController,
                    tabs: [for (var conf in conferences) Tab(text: conf)],
                  )
                : null,
          ),
          body: SafeArea(
            child: DecoratedContainer(
              child: Center(child: _pages.elementAt(_navIndex)),
            ),
          ),
        ),
      ),
    );
  }
}
