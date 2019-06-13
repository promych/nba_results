import 'package:bloc/bloc.dart';
import 'package:nba_results/blocs/standings_events.dart';
import 'package:nba_results/blocs/standings_states.dart';
import 'package:nba_results/repositories/stendings.dart';

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
