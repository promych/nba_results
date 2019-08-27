import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './scoreboard_events.dart';
import './scoreboard_states.dart';
import '../repositories/scoreboard.dart';

class ScoreboardBloc extends Bloc<ScoreboardEvent, ScoreboardState> {
  final Scoreboard scoreboard;

  ScoreboardBloc({@required this.scoreboard});

  @override
  get initialState => ScorepoardInitialized();

  @override
  Stream<ScoreboardState> mapEventToState(event) async* {
    if (event is FetchGames) {
      yield ScoreboardLoading();
      try {
        final games = await scoreboard.fetchGames(event.byDate);
        yield ScoreboardLoaded(games: games);
      } catch (error) {
        yield ScoreboardError(message: error.toString());
      }
    }
  }
}
