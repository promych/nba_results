import 'package:flutter/material.dart';

import '../models/game.dart';
import '../ui/game_card.dart';

class GameList extends StatelessWidget {
  final List<Game> games;

  const GameList({Key key, @required this.games});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10.0),
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        return GameCard(game: games[index]);
      },
    );
  }
}
