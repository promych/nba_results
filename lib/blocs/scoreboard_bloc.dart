import 'package:bloc/bloc.dart';

import './scoreboard_events.dart';
import './scoreboard_states.dart';
import '../repositories/scoreboard.dart';

class ScoreboardBloc extends Bloc<ScoreboardEvent, ScoreboardState> {
  final ScoreboardRepo repo;

  ScoreboardBloc({required this.repo}) : super(ScorepoardInitialized()) {
    on<FetchGames>(_emitGames);
  }

  Future<void> _emitGames(FetchGames event, Emitter emit) async {
    emit(ScoreboardLoading());
    try {
      final games = await repo.fetchGames(event.byDate);
      emit(ScoreboardLoaded(games: games));
    } catch (error) {
      emit(ScoreboardError(message: error.toString()));
    }
  }
}
