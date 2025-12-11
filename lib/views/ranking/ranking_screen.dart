import 'package:flutter/material.dart';
import '../../controllers/ranking_controller_rest.dart';
import '../../models/ranking_entry.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});
  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final RankingControllerRest _ranking = RankingControllerRest();
  late Future<List<RankingEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = _ranking.loadTop10();
  }

  Widget _card(RankingEntry e, int index) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.indigo, child: Text('${index + 1}', style: const TextStyle(color: Colors.white))),
        title: Text(e.nickname, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${e.completionTime}s • ${e.completedAt.toLocal().toString().split('.').first}'),
        trailing: Text('${e.completionTime}s', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.of(context).pop()), title: const Text('Ranking', style: TextStyle(color: Colors.black87))),
      body: FutureBuilder<List<RankingEntry>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Erro: ${snap.error}'));
          final list = snap.data ?? [];
          if (list.isEmpty) return const Center(child: Text('Nenhuma pontuação ainda'));
          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            itemCount: list.length,
            itemBuilder: (_, i) => _card(list[i], i),
          );
        },
      ),
    );
  }
}
