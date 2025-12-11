import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _loading = false;

  Future<void> _clearNickname() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('nickname');
    setState(() => _loading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nickname removido')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.of(context).pop()), title: const Text('Configurações', style: TextStyle(color: Colors.black87))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: ListTile(
                leading: const Icon(Icons.person_off, color: Colors.black87),
                title: const Text('Remover nickname local'),
                subtitle: const Text('Apaga o nickname salvo no dispositivo'),
                trailing: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()) : null,
                onTap: _clearNickname,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: ListTile(
                leading: const Icon(Icons.restore, color: Colors.black87),
                title: const Text('Limpar ranking local'),
                subtitle: const Text('Não afeta o ranking online'),
                onTap: () async {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Limpeza simulada')));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
