import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pick_date_bloc.dart';
import '../blocs/pick_date_events.dart';
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
          if (state.games.isEmpty) {
            return Text('No Games :(');
          } else {
            BlocProvider.of<PickDateBloc>(context).dispatch(PickDateSelect(
                selectedDate: DateTime.parse(state.games.first.dateTime)));
            return GameList(games: state.games);
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
