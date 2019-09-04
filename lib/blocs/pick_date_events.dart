import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class PickDateEvent extends Equatable {
  PickDateEvent([List props = const []]) : super(props);
}

class PickDateSelect extends PickDateEvent {
  final DateTime selectedDate;

  PickDateSelect({this.selectedDate}) : super([selectedDate]);
}
