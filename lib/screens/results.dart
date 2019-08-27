import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/scoreboard_bloc.dart';
import '../blocs/scoreboard_states.dart';
import '../ui/game_list.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreboardBloc, ScoreboardState>(
      builder: (BuildContext context, ScoreboardState state) {
        if (state is ScoreboardError) {
          return Text('error: ${state.message}');
        } else if (state is ScoreboardLoaded) {
          return state.games.isEmpty
              ? Text('No Games :(')
              : GameList(games: state.games);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
