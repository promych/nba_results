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
      awayTeam: Team(
        name: awayTeamJson['team']['shortDisplayName'],
        abbreviation: awayTeamJson['team']['abbreviation'],
        color: awayTeamJson['team']['color'] ?? '000000',
        logoUrl: awayTeamJson['team']['logo'],
        score: awayTeamJson['score'],
        records: awayTeamJson.containsKey('records')
            ? awayTeamJson['records'][0]['summary']
            : '0-0',
      ),
      homeTeam: Team(
        name: homeTeamJson['team']['shortDisplayName'],
        abbreviation: homeTeamJson['team']['abbreviation'],
        color: homeTeamJson['team']['color'] ?? '000000',
        logoUrl: homeTeamJson['team']['logo'],
        score: homeTeamJson['score'],
        records: homeTeamJson.containsKey('records')
            ? homeTeamJson['records'][0]['summary']
            : '0-0',
      ),
      status: json['status']['type']['description'],
    );
  }
}
