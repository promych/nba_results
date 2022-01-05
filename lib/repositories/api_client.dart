import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game.dart';
import '../models/team.dart';

class ApiClient {
  Future<List<Game>> getScoreboard(DateTime byDate) async {
    String url =
        'http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard';
    url = url + '?dates=' + byDate.toString().split(' ')[0].replaceAll('-', '');
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      Iterable data = List.from(body['events']);
      List<Game> result = data.map((json) => Game.fromJson(json)).toList();
      return result;
    } else {
      return throw Exception('Error getting scoreboard');
    }
  }

  Future<List<Team>> getStandings() async {
    String url =
        'http://data.nba.net/10s/prod/v1/current/standings_conference.json';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body =
          json.decode(response.body)['league']['standard']['conference'];

      List<Team> teams = List.from(body['east'])
          .map((json) => Team.fromStandingsJson(json, 'East'))
          .toList();
      teams.addAll(List.from(body['west'])
          .map((json) => Team.fromStandingsJson(json, 'West'))
          .toList());

      return teams;
    } else {
      return throw Exception('Error getting standings');
    }
  }
}
