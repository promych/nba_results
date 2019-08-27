import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/game.dart';

@immutable
abstract class ScoreboardState extends Equatable {
  ScoreboardState([List props = const []]) : super(props);
}

class ScorepoardInitialized extends ScoreboardState {}

class ScoreboardLoading extends ScoreboardState {}

class ScoreboardLoaded extends ScoreboardState {
  final List<Game> games;

  ScoreboardLoaded({@required this.games});
}

class ScoreboardError extends ScoreboardState {
  final String message;

  ScoreboardError({@required this.message});
}
