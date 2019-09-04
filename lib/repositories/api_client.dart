import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game.dart';
import '../models/team.dart';

class ApiClient {
  Future<List<Game>> getScoreboard(DateTime byDate) async {
    print('get results');
    String url =
        'http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard';
    if (byDate != null)
      url =
          url + '?dates=' + byDate.toString().split(' ')[0].replaceAll('-', '');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      Iterable data = List.from(body['events']);
      List<Game> result = data.map((json) => Game.fromJson(json)).toList();
      return result;
    } else {
      return throw Exception('Error getting scoreboard');
    }
  }

  Future<String> _getCurrentSeasonYear() async {
    const String url = 'http://data.nba.net/json/cms/today.json';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json
          .decode(response.body)['sports_content']['sports_meta']['season_meta']
              ['standings_season_year']
          .toString();
    } else {
      return throw Exception('Error getting current season');
    }
  }

  Future<List<Team>> getStandings() async {
    print('get standings');
    String year = await _getCurrentSeasonYear();
    // String year = '2018';
    String url = 'http://data.nba.net/json/cms/$year/standings/conference.json';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = json.decode(response.body)['sports_content']['standings']
          ['conferences'];
      Iterable data = List.from(body['East']['team']);
      List<Team> teams =
          data.map((json) => Team.fromStandingsJson(json, 'East')).toList();
      data = List.from(body['West']['team']);
      teams.addAll(
          data.map((json) => Team.fromStandingsJson(json, 'West')).toList());
      return teams;
    } else {
      return throw Exception('Error getting standings');
    }
  }
}
