import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nba_results/repositories/api_client.dart';
import 'package:nba_results/repositories/standings.dart';

import './repositories/constants.dart';
import './blocs/pick_date_states.dart';
import './blocs/pick_date_bloc.dart';
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

  late ApiClient _apiClient;
  late PickDateBloc _pickDateBloc;
  late ScoreboardBloc _scoreboardBloc;
  late StandingsBloc _standingsBloc;
  late AnimationController _switchController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _pickDateBloc = PickDateBloc();
    _apiClient = ApiClient();
    _scoreboardBloc = ScoreboardBloc(repo: ScoreboardRepo(_apiClient));
    _standingsBloc = StandingsBloc(repo: StandingsRepo(_apiClient));
    _scoreboardBloc.add(FetchGames(byDate: DateTime.now()));
    _standingsBloc.add(FetchStandings());

    _switchController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    _pages = [
      ResultsPage(),
      StandingsPage(tabController: _tabController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PickDateBloc>.value(value: _pickDateBloc),
        BlocProvider<ScoreboardBloc>(create: (_) => _scoreboardBloc),
        BlocProvider<StandingsBloc>(create: (_) => _standingsBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('NBA Results'),
                BlocBuilder<PickDateBloc, PickDateState>(
                  builder: (_, state) {
                    if (state is PickDateSelected) {
                      return Text(
                        DateFormat.yMMMMd().format(
                          DateTime.parse(state.selectedDate.toIso8601String()),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
            backgroundColor: Colors.grey[800],
            leading: DatePicker(isVisible: _navIndex == 0),
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
