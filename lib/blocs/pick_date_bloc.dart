import 'package:bloc/bloc.dart';

import './pick_date_events.dart';
import './pick_date_states.dart';

class PickDateBloc extends Bloc<PickDateEvent, PickDateState> {
  PickDateBloc() : super(PickDateInit()) {
    on<PickDateSelect>(_emitPickDate);
  }

  Future<void> _emitPickDate(PickDateSelect event, Emitter emit) async {
    try {
      emit(PickDateSelected(selectedDate: event.selectedDate));
    } catch (error) {
      emit(PickDateError(message: error.toString()));
    }
  }
}
