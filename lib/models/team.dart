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
  final String pct;
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
      this.pct,
      this.confWinLoss,
      this.rank,
      this.streak,
      this.conference});

  static Team fromStandingsJson(Map<String, dynamic> json, String conference) {
    var stats = json['team_stats'];
    return Team(
      name: json['nickname'],
      abbreviation: json['abbreviation'],
      wins: stats['wins'],
      losses: stats['losses'],
      pct: stats['pct'].trim(),
      confWinLoss: stats['conf_win_loss'],
      rank: stats['rank'],
      streak: stats['l10'],
      conference: conference,
    );
  }

  static Team fromScoreboardJson(Map<String, dynamic> json) {
    return Team(
      name: json['team']['shortDisplayName'],
      abbreviation: json['team']['abbreviation'] ??
          (json['team']['shortDisplayName'] as String)
              .substring(0, 3)
              .toUpperCase(),
      color: json['team']['color'] ?? '000000',
      logoUrl: json['team']['logo'],
      score: json['score'],
      records:
          json.containsKey('records') ? json['records'][0]['summary'] : '0-0',
    );
  }
}
