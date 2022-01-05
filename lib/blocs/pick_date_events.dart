import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class PickDateEvent extends Equatable {
  PickDateEvent([List props = const []]);

  @override
  List<Object> get props => props;
}

class PickDateSelect extends PickDateEvent {
  final DateTime selectedDate;

  PickDateSelect({required this.selectedDate}) : super([selectedDate]);
}
