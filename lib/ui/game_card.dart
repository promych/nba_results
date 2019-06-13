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
  bool showScore;
  String gameDate;
  bool isGameScheduled;

  @override
  void initState() {
    showScore = false;
    gameDate =
        DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.game.dateTime));
    isGameScheduled = widget.game.status == 'Scheduled';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showScore = !showScore;
        });
      },
      child: Card(
        key: ValueKey('${widget.game.name}'),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: widget.game.awayTeam.logoUrl,
                        height: 40.0,
                      ),
                      TeamTitle(
                        team: widget.game.awayTeam,
                        withScore: showScore,
                        isGameScheduled: isGameScheduled,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text('@', style: TextStyle(fontSize: 24.0)),
                  ),
                  Row(
                    children: <Widget>[
                      TeamTitle(
                        team: widget.game.homeTeam,
                        withScore: showScore,
                        isGameScheduled: isGameScheduled,
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.game.homeTeam.logoUrl,
                        height: 40.0,
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: AnimatedPadding(
                  padding: showScore
                      ? const EdgeInsets.only(top: 10.0)
                      : const EdgeInsets.only(top: 0.0),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceOut,
                  child: showScore
                      ? Text('${widget.game.status}: $gameDate')
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
