import 'package:bloc/bloc.dart';

import './standings_events.dart';
import './standings_states.dart';
import '../repositories/standings.dart';

class StandingsBloc extends Bloc<StandingsEvent, StandingsState> {
  final StandingsRepo repo;

  StandingsBloc({required this.repo}) : super(StandingsInitialized()) {
    on<FetchStandings>(_emitStandings);
  }

  Future<void> _emitStandings(_, Emitter emit) async {
    emit(StandingsLoading());
    try {
      final teams = await repo.fetchStandings();
      emit(StandingsLoaded(teams: teams));
    } catch (error) {
      emit(StandingsError(message: error.toString()));
    }
  }
}
