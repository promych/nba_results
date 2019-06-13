import 'package:flutter/material.dart';
import 'package:nba_results/models/team.dart';

class StandingsList extends StatefulWidget {
  final List<Team> teams;

  const StandingsList({Key key, @required this.teams}) : super(key: key);

  @override
  _StandingsListState createState() => _StandingsListState();
}

class _StandingsListState extends State<StandingsList>
    with AutomaticKeepAliveClientMixin<StandingsList> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(children: [
        _ConferenceTable(
          conference: 'Eastern',
          teams: _teamsByConference('East'),
        ),
        SizedBox(
          height: 20.0,
        ),
        _ConferenceTable(
          conference: 'Western',
          teams: _teamsByConference('West'),
        )
      ]),
    );
  }

  List<Team> _teamsByConference(String conference) {
    return widget.teams.where((e) => e.conference == conference).toList()
      ..sort((a, b) => int.parse(a.rank).compareTo(int.parse(b.rank)));
  }

  @override
  bool get wantKeepAlive => true;
}

class _ConferenceTable extends StatelessWidget {
  final String conference;
  final List<Team> teams;

  const _ConferenceTable({@required this.conference, @required this.teams});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$conference',
          style: TextStyle(fontSize: 36.0),
        ),
        Table(
            border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey[400])),
            children: List.from([_headRow(context)])
              ..addAll(_createTable(context)))
      ],
    );
  }

  TableRow _headRow(BuildContext context) {
    return TableRow(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 25.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text('Team'),
          ),
          Text('Wins'),
          Text('Losses'),
          Text('Conf'),
          Text('Last 10'),
        ],
      )
    ]);
  }

  List<TableRow> _createTable(BuildContext context) {
    return teams.map<TableRow>((team) {
      return TableRow(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: int.parse(team.rank) < 9 ? Text(team.rank) : Container(),
              width: 10.0,
            ),
            Container(
              child: Text(team.name),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Text(team.wins),
            Text(team.losses),
            Text(team.confWinLoss),
            Text(team.streak),
          ],
        )
      ]);
    }).toList();
  }
}
