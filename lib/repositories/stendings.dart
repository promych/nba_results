import '../models/team.dart';
import '../repositories/api_client.dart';

class Standings {
  final ApiClient _apiClient = ApiClient();

  Future<List<Team>> fetchStandings() async {
    return await _apiClient.getStandings();
  }
}
