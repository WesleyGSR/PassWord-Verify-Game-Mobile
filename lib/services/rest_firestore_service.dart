import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ranking_entry.dart';

class RestFirestoreService {
  final String projectId = "password-verify-d9440";
  final String apiKey = "AIzaSyBW2o0uame6-01q-9VGtVDX1wC3JGCsc90";

  String get baseUrl =>
      "https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents";

  /// Save an entry (creates a document with auto id)
  Future<void> addRankingEntry(RankingEntry entry) async {
    final url = Uri.parse("$baseUrl/ranking?key=$apiKey");
    final body = {
      "fields": {
        "nickname": {"stringValue": entry.nickname},
        "completionTime": {"integerValue": entry.completionTime.toString()},
        "completedAt": {"timestampValue": entry.completedAt.toUtc().toIso8601String()},
      }
    };

    final resp = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    if (resp.statusCode >= 300) {
      throw Exception('Erro ao salvar ranking: ${resp.statusCode} ${resp.body}');
    }
  }

  /// Get top ranking ordered by completionTime ascending (limited)
  Future<List<RankingEntry>> getTopRanking({int limit = 10}) async {
    // Firestore REST supports runQuery for ordering; however for simplicity we try list + client-side sort
    final url = Uri.parse("$baseUrl/ranking?key=$apiKey&pageSize=$limit");
    final resp = await http.get(url);
    if (resp.statusCode >= 300) {
      throw Exception('Erro ao carregar ranking: ${resp.statusCode} ${resp.body}');
    }

    final json = jsonDecode(resp.body);
    final docs = json['documents'] as List<dynamic>? ?? [];

    final entries = docs.map((doc) {
      final f = doc['fields'] as Map<String, dynamic>;
      final nickname = f['nickname']?['stringValue'] as String? ?? '---';
      final completionTimeStr = f['completionTime']?['integerValue']?.toString();
      final completedAtStr = f['completedAt']?['timestampValue'] as String?;
      final completionTime = completionTimeStr != null ? int.parse(completionTimeStr) : 0;
      final completedAt = completedAtStr != null ? DateTime.parse(completedAtStr) : DateTime.now();
      return RankingEntry(nickname: nickname, completionTime: completionTime, completedAt: completedAt);
    }).toList();

    // sort ascending by completionTime
    entries.sort((a, b) => a.completionTime.compareTo(b.completionTime));
    return entries.take(limit).toList();
  }
}
