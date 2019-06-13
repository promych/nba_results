import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StandingsEvent extends Equatable {
  StandingsEvent([List props = const []]) : super(props);
}

class FetchStandings extends StandingsEvent {}
