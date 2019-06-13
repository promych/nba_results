import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_results/blocs/standings_bloc.dart';
import 'package:nba_results/blocs/standings_events.dart';
import 'package:nba_results/blocs/standings_states.dart';
import 'package:nba_results/ui/standings_list.dart';

class StandingsPage extends StatefulWidget {
  @override
  _StandingsPageState createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage>
    with AutomaticKeepAliveClientMixin<StandingsPage> {
  StandingsBloc _standingsBloc;

  @override
  void initState() {
    super.initState();
    _standingsBloc = StandingsBloc();
    _standingsBloc.dispatch(FetchStandings());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      builder: (context) => _standingsBloc,
      child: BlocBuilder(
          bloc: _standingsBloc,
          builder: (BuildContext context, StandingsState state) {
            if (state is StandingsInitialized) {
              return Container();
            }
            if (state is StandingsLoading) {
              return CircularProgressIndicator();
            }
            if (state is StandingsError) {
              return Text('Error: ${state.message}');
            }
            if (state is StandingsLoaded) {
              return StandingsList(teams: state.teams);
            }
          }),
    );
  }

  @override
  void dispose() {
    _standingsBloc.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
