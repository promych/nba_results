import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nba_results/models/team.dart';

@immutable
class Game extends Equatable {
  final String gameId;
  final String name;
  final String dateTime;
  final Team awayTeam;
  final Team homeTeam;

  final String status;

  Game(
      {this.gameId,
      this.name,
      this.dateTime,
      this.awayTeam,
      this.homeTeam,
      this.status});

  static Game fromJson(Map<String, dynamic> json) {
    var awayTeamJson = json['competitions'][0]['competitors'][1]['team'];
    var homeTeamJson = json['competitions'][0]['competitors'][0]['team'];
    return Game(
      gameId: json['id'],
      name: json['name'],
      dateTime: json['competitions'][0]['date'],
      awayTeam: Team(
          name: awayTeamJson['shortDisplayName'],
          abbreviation: awayTeamJson['abbreviation'],
          color: awayTeamJson['color'],
          logoUrl: awayTeamJson['logo'],
          score: json['competitions'][0]['competitors'][1]['score'],
          records: json['competitions'][0]['competitors'][1]['records'][0]
              ['summary']),
      homeTeam: Team(
          name: homeTeamJson['shortDisplayName'],
          abbreviation: homeTeamJson['abbreviation'],
          color: homeTeamJson['color'],
          logoUrl: homeTeamJson['logo'],
          score: json['competitions'][0]['competitors'][0]['score'],
          records: json['competitions'][0]['competitors'][0]['records'][0]
              ['summary']),
      status: json['status']['type']['description'],
    );
  }
}
