import 'package:flutter/material.dart';
import 'package:nba_results/models/team.dart';

class TeamTitle extends StatelessWidget {
  final Team team;
  final bool withScore;
  final bool isGameScheduled;

  const TeamTitle(
      {Key key,
      @required this.team,
      this.withScore = false,
      this.isGameScheduled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${team.abbreviation}',
          style: TextStyle(
            color: Color(int.parse('0x${team.color}') + 0xFF000000),
            fontSize: 32.0,
          ),
        ),
        Container(
          child: Center(
            child: withScore
                ? Text(
                    isGameScheduled ? '${team.records}' : '${team.score}',
                    style: TextStyle(fontSize: 20.0),
                  )
                : Text('${team.name}'),
          ),
          width: MediaQuery.of(context).size.width / 2 - 100.0,
        ),
      ],
    );
  }
}
