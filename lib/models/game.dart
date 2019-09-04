import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/team.dart';

@immutable
class Game extends Equatable {
  final String gameId;
  final String name;
  final String dateTime;
  final Team awayTeam;
  final Team homeTeam;
  final String status;

  Game({
    this.gameId,
    this.name,
    this.dateTime,
    this.awayTeam,
    this.homeTeam,
    this.status,
  });

  static Game fromJson(Map<String, dynamic> json) {
    final awayTeamJson = json['competitions'][0]['competitors'][1];
    final homeTeamJson = json['competitions'][0]['competitors'][0];
    return Game(
      gameId: json['id'],
      name: json['name'],
      dateTime: json['competitions'][0]['date'],
      awayTeam: Team.fromScoreboardJson(awayTeamJson),
      homeTeam: Team.fromScoreboardJson(homeTeamJson),
      status: json['status']['type']['description'],
    );
  }
}
