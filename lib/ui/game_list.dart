import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../models/game.dart';
import '../ui/game_card.dart';

class GameList extends StatelessWidget {
  final List<Game> games;

  const GameList({required this.games});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: games.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FlipAnimation(
                child: GameCard(game: games[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
