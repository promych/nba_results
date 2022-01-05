import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pick_date_bloc.dart';
import '../blocs/pick_date_events.dart';
import '../blocs/scoreboard_bloc.dart';
import '../blocs/scoreboard_events.dart';

class DatePicker extends StatelessWidget {
  final bool isVisible;

  const DatePicker({this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isVisible ? Icon(Icons.date_range) : Container(),
      onPressed: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final nowDate = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: nowDate,
        firstDate: nowDate.subtract(const Duration(days: 365)),
        lastDate: nowDate.add(const Duration(days: 365)),
        builder: (BuildContext context, Widget? child) {
          return child ?? const SizedBox();
        });
    if (pickedDate == null) return;
    BlocProvider.of<PickDateBloc>(context)
        .add(PickDateSelect(selectedDate: pickedDate));
    BlocProvider.of<ScoreboardBloc>(context)
        .add(FetchGames(byDate: pickedDate));
  }
}
