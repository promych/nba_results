import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ScoreboardEvent extends Equatable {
  ScoreboardEvent([List props = const []]) : super(props);
}

class FetchGames extends ScoreboardEvent {
  final DateTime byDate;

  FetchGames({this.byDate}) : super([byDate]);
}
