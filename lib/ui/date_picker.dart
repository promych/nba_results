import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_results/blocs/scoreboard_bloc.dart';
import 'package:nba_results/blocs/scoreboard_events.dart';

class DatePicker extends StatelessWidget {
  final bool isVisible;

  const DatePicker({Key key, this.isVisible = true}) : super(key: key);

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
        builder: (BuildContext context, Widget child) {
          return child;
        });
    if (pickedDate == null) return;
    BlocProvider.of<ScoreboardBloc>(context)
        .dispatch(FetchGames(byDate: pickedDate));
  }
}
