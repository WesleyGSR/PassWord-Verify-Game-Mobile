import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const _prefNickname = 'USER_NICKNAME';

  /// Salva nickname localmente
  Future<void> saveNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefNickname, nickname);
  }

  /// Recupera nickname local (ou null)
  Future<String?> getLocalNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefNickname);
  }

  /// Retorna nickname ou "Visitante" se não existir
  Future<String> getCurrentNicknameOrDefault() async {
    final local = await getLocalNickname();
    if (local != null && local.isNotEmpty) return local;
    return 'Visitante';
  }

  /// Remove nickname (logout local)
  Future<void> clearNickname() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefNickname);
  }
}
