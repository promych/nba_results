import '../models/team.dart';
import '../repositories/api_client.dart';

class StandingsRepo {
  final ApiClient _apiClient;

  StandingsRepo(this._apiClient);

  Future<List<Team>> fetchStandings() async {
    return await _apiClient.getStandings();
  }
}
