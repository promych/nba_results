import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ScoreboardEvent extends Equatable {
  ScoreboardEvent([List props = const []]);

  @override
  List<Object> get props => props;
}

class FetchGames extends ScoreboardEvent {
  final DateTime byDate;

  FetchGames({required this.byDate}) : super([byDate]);
}
