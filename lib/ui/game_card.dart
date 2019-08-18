import 'package:flutter/material.dart';
import 'package:nba_results/models/game.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nba_results/ui/team_title.dart';
import 'package:intl/intl.dart';

class GameCard extends StatefulWidget {
  final Game game;

  const GameCard({Key key, @required this.game}) : super(key: key);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool _showScore;
  String _gameDate;
  bool _isGameScheduled;

  @override
  void initState() {
    super.initState();
    _showScore = false;
    _gameDate =
        DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.game.dateTime));
    _isGameScheduled = widget.game.status == 'Scheduled';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showScore = !_showScore;
        });
      },
      child: Card(
        key: ValueKey('${widget.game.name}'),
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.game.awayTeam.logoUrl,
                        height: 40.0,
                      ),
                      TeamTitle(
                        team: widget.game.awayTeam,
                        withScore: _showScore,
                        isGameScheduled: _isGameScheduled,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text('@', style: TextStyle(fontSize: 24.0)),
                  ),
                  Row(
                    children: [
                      TeamTitle(
                        team: widget.game.homeTeam,
                        withScore: _showScore,
                        isGameScheduled: _isGameScheduled,
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.game.homeTeam.logoUrl,
                        height: 40.0,
                      ),
                    ],
                  ),
                ],
              ),
              AnimatedPadding(
                padding: _showScore
                    ? const EdgeInsets.only(top: 10.0)
                    : const EdgeInsets.only(top: 0.0),
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceOut,
                child: _showScore
                    ? Text(
                        '${widget.game.status}\n$_gameDate',
                        textAlign: TextAlign.center,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
