import 'package:flutter/material.dart';
import 'package:nba_results/blocs/scoreboard_bloc.dart';
import 'package:nba_results/blocs/scoreboard_events.dart';
import 'package:nba_results/blocs/scoreboard_states.dart';
import 'package:nba_results/repositories/scoreboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_results/ui/game_list.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with AutomaticKeepAliveClientMixin<ResultsPage> {
  ScoreboardBloc _scoreboardBloc;

  @override
  void initState() {
    super.initState();
    _scoreboardBloc = ScoreboardBloc(scoreboard: Scoreboard());
    _scoreboardBloc.dispatch(FetchGames());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<ScoreboardBloc>(
      builder: (context) => _scoreboardBloc,
      child: BlocBuilder<ScoreboardEvent, ScoreboardState>(
        bloc: _scoreboardBloc,
        builder: (BuildContext context, ScoreboardState state) {
          if (state is ScorepoardInitialized) {
            return Container();
          }
          if (state is ScoreboardLoading) {
            return CircularProgressIndicator();
          }
          if (state is ScoreboardError) {
            return Text('error: ${state.message}');
          }
          if (state is ScoreboardLoaded) {
            return GameList(games: state.games);
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scoreboardBloc.dispose();
    super.dispose();
  }
}
