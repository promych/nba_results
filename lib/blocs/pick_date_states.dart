import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PickDateState extends Equatable {
  PickDateState([List props = const []]) : super(props);
}

class PickDateInit extends PickDateState {}

class PickDateError extends PickDateState {
  final String message;

  PickDateError({@required this.message});
}

class PickDateSelected extends PickDateState {
  final DateTime selectedDate;

  PickDateSelected({@required this.selectedDate});
}
