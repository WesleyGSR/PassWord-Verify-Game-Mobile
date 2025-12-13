import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestAuthService {
  final String apiKey = dotenv.env['FIREBASE_API_KEY'] ?? '';
  String? idToken;

  Future<String?> getIdToken() async {
    if (idToken != null) return idToken;
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
    final resp = await http.post(url, body: jsonEncode({'returnSecureToken': true}), headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      idToken = data['idToken'];
      return idToken;
    } else {
      // Not fatal: if API key allows unauthenticated Firestore reads, code still works.
      return null;
    }
  }
}
