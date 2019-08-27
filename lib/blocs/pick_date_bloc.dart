import 'package:bloc/bloc.dart';

import './pick_date_events.dart';
import './pick_date_states.dart';

class PickDateBloc extends Bloc<PickDateEvent, PickDateState> {
  @override
  get initialState => PickDateInit();

  @override
  Stream<PickDateState> mapEventToState(event) async* {
    yield PickDateInit();
    if (event is PickDateSelect) {
      try {
        yield PickDateSelected(selectedDate: event.selectedDate);
      } catch (error) {
        yield PickDateError(message: error.toString());
      }
    }
  }
}
