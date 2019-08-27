import '../models/game.dart';
import '../repositories/api_client.dart';

class Scoreboard {
  final _apiClient = ApiClient();

  Future<List<Game>> fetchGames(DateTime byDate) async {
    return await _apiClient.getScoreboard(byDate);
  }
}
