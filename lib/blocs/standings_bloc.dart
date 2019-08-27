import 'package:bloc/bloc.dart';

import './standings_events.dart';
import './standings_states.dart';
import '../repositories/stendings.dart';

class StandingsBloc extends Bloc<StandingsEvent, StandingsState> {
  final Standings _standings = Standings();

  @override
  StandingsState get initialState => StandingsInitialized();

  @override
  Stream<StandingsState> mapEventToState(StandingsEvent event) async* {
    if (event is FetchStandings) {
      yield StandingsLoading();
      try {
        final teams = await _standings.fetchStandings();
        yield StandingsLoaded(teams: teams);
      } catch (error) {
        yield StandingsError(message: error.toString());
      }
    }
  }
}
