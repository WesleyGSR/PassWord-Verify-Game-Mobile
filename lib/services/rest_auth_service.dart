import 'dart:convert';
import 'package:http/http.dart' as http;

class RestAuthService {
  final String apiKey = "AIzaSyBW2o0uame6-01q-9VGtVDX1wC3JGCsc90";
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
