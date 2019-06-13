import 'package:nba_results/models/team.dart';
import 'package:nba_results/repositories/api_client.dart';

class Standings {
  final ApiClient _apiClient = ApiClient();

  Future<List<Team>> fetchStandings() async {
    return await _apiClient.getStandings();
  }
}
