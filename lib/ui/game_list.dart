import 'package:flutter/material.dart';

import '../models/game.dart';
import '../ui/game_card.dart';

class GameList extends StatefulWidget {
  final List<Game> games;

  const GameList({Key key, @required this.games}) : super(key: key);

  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey('Results'),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10.0),
      itemCount: widget.games.length,
      itemBuilder: (BuildContext context, int index) {
        return GameCard(game: widget.games[index]);
      },
    );
  }
}
