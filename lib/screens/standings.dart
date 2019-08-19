import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/standings_bloc.dart';
import '../blocs/standings_states.dart';
import '../ui/standings_list.dart';

class StandingsPage extends StatelessWidget {
  final TabController tabController;

  const StandingsPage({this.tabController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StandingsBloc, StandingsState>(
      builder: (BuildContext context, StandingsState state) {
        if (state is StandingsError) {
          return Text('Error: ${state.message}');
        } else if (state is StandingsLoaded) {
          return StandingsList(
            teams: state.teams,
            tabController: tabController,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
