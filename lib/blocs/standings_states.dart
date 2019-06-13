import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nba_results/models/team.dart';

@immutable
abstract class StandingsState extends Equatable {
  StandingsState([List props = const []]) : super(props);
}

class StandingsInitialized extends StandingsState {}

class StandingsLoading extends StandingsState {}

class StandingsError extends StandingsState {
  final String message;

  StandingsError({@required this.message});
}

class StandingsLoaded extends StandingsState {
  final List<Team> teams;

  StandingsLoaded({@required this.teams});
}
