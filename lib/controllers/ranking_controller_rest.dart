import '../models/ranking_entry.dart';
import '../services/rest_firestore_service.dart';

class RankingControllerRest {
  final RestFirestoreService service = RestFirestoreService();

  Future<void> saveCompletion(String nickname, int seconds) {
    final entry = RankingEntry(nickname: nickname, completionTime: seconds, completedAt: DateTime.now());
    return service.addRankingEntry(entry);
  }

  Future<List<RankingEntry>> loadTop10() {
    return service.getTopRanking(limit: 10);
  }
}
