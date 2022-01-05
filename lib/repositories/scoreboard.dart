import '../models/game.dart';
import '../repositories/api_client.dart';

class ScoreboardRepo {
  final ApiClient _apiClient;

  ScoreboardRepo(this._apiClient);

  Future<List<Game>> fetchGames(DateTime byDate) async {
    return await _apiClient.getScoreboard(byDate);
  }
}
