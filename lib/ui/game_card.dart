import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/game.dart';
import '../ui/team_title.dart';

class GameCard extends StatefulWidget {
  final Game game;

  const GameCard({Key key, @required this.game}) : super(key: key);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool _showScore;
  bool _isGameScheduled;

  @override
  void initState() {
    super.initState();
    _showScore = false;
    _isGameScheduled = widget.game.status == 'Scheduled';
  }

  @override
  Widget build(BuildContext context) {
    final _gameTime = DateFormat.Hm()
        .format(DateTime.parse(widget.game.dateTime).toLocal()); //yMMMMEEEEd
    return GestureDetector(
      onTap: () {
        setState(() {
          _showScore = !_showScore;
        });
      },
      child: Card(
        key: ValueKey('${widget.game.name}'),
        elevation: 5.0,
        child: Container(
          height: 100.0,
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: -50.0,
                          child: Opacity(
                            opacity: 0.1,
                            child: widget.game.awayTeam.logoUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: widget.game.awayTeam.logoUrl,
                                    height: 150.0,
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: -50.0,
                          child: Opacity(
                            opacity: 0.1,
                            child: widget.game.homeTeam.logoUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: widget.game.homeTeam.logoUrl,
                                    height: 150.0,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TeamTitle(
                        team: widget.game.awayTeam,
                        withScore: _showScore,
                        isGameScheduled: _isGameScheduled,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('@', style: TextStyle(fontSize: 24.0)),
                      Text(
                        widget.game.status != 'Final'
                            ? '$_gameTime'
                            : '${widget.game.status}',
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TeamTitle(
                        team: widget.game.homeTeam,
                        withScore: _showScore,
                        isGameScheduled: _isGameScheduled,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
