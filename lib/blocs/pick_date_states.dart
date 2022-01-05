import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PickDateState extends Equatable {
  PickDateState([List props = const []]);

  @override
  List<Object> get props => props;
}

class PickDateInit extends PickDateState {}

class PickDateError extends PickDateState {
  final String message;

  PickDateError({required this.message}) : super([message]);
}

class PickDateSelected extends PickDateState {
  final DateTime selectedDate;

  PickDateSelected({required this.selectedDate}) : super([selectedDate]);
}
