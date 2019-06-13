import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class Team extends Equatable {
  final String name;
  final String abbreviation;
  final String logoUrl;
  final String color;
  final String score;
  final String records;
  final String wins;
  final String losses;
  final String confWinLoss;
  final String rank;
  final String streak;
  final String conference;

  Team(
      {@required this.name,
      @required this.abbreviation,
      this.logoUrl,
      this.color,
      this.score,
      this.records,
      this.wins,
      this.losses,
      this.confWinLoss,
      this.rank,
      this.streak,
      this.conference});

  static Team fromJson(Map<String, dynamic> json, String conference) {
    var stats = json['team_stats'];
    return Team(
      name: json['nickname'],
      abbreviation: json['abbreviation'],
      wins: stats['wins'],
      losses: stats['losses'],
      confWinLoss: stats['conf_win_loss'],
      rank: stats['rank'],
      streak: stats['l10'],
      conference: conference,
    );
  }
}
