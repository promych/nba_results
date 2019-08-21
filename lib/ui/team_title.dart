import 'package:flutter/material.dart';
import 'package:nba_results/models/team.dart';

class TeamTitle extends StatelessWidget {
  final Team team;
  final bool withScore;
  final bool isGameScheduled;

  const TeamTitle({
    Key key,
    @required this.team,
    this.withScore = false,
    this.isGameScheduled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        withScore
            ? Text(
                isGameScheduled ? '${team.records}' : '${team.score}',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Color(int.parse('0x${team.color}') + 0xFF000000),
                ),
              )
            : Text(
                '${team.abbreviation}',
                style: TextStyle(
                  color: Color(int.parse('0x${team.color}') + 0xFF000000),
                  fontSize: 32.0,
                ),
              ),
        Text(
          '${team.name}',
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}
