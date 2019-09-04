import 'package:flutter/material.dart';

import '../models/team.dart';

class TeamTitle extends StatelessWidget {
  final Team team;
  final bool withScore;
  final bool isGameScheduled;
  final TextStyle _teamTextStyle;

  TeamTitle({
    @required this.team,
    this.withScore = false,
    this.isGameScheduled = true,
  }) : _teamTextStyle = TextStyle(
          fontSize: 32.0,
          color: Color(int.parse('0x${team.color}') + 0xFF000000),
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) => ScaleTransition(
            child: child,
            scale: animation,
          ),
          child: withScore
              ? Text(
                  (isGameScheduled ? '${team.records}' : '${team.score}'),
                  key: ValueKey('$team-score'),
                  style: _teamTextStyle,
                )
              : Text(
                  '${team.abbreviation}',
                  key: ValueKey('$team-name'),
                  style: _teamTextStyle,
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
