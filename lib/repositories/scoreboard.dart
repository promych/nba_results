import 'package:nba_results/models/game.dart';
import 'package:nba_results/repositories/api_client.dart';

class Scoreboard {
  final _apiClient = ApiClient();

  Future<List<Game>> fetchGames() async {
    return await _apiClient.getScoreboard();
  }
}
