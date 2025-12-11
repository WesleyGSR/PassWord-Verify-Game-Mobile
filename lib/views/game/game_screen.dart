import 'package:flutter/material.dart';
import '../../controllers/ranking_controller_rest.dart';
import '../../models/password_validator.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _pwCtrl = TextEditingController();
  final RankingControllerRest _ranking = RankingControllerRest();

  late final int _startMs;
  bool _isSaving = false;
  String? _nextRule;
  bool _allPassed = false;

  // animation for lock swap
  late AnimationController _anim;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _startMs = DateTime.now().millisecondsSinceEpoch;
    _pwCtrl.addListener(_onChanged);

    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeInOut);

    _onChanged();
  }

  @override
  void dispose() {
    _pwCtrl.removeListener(_onChanged);
    _pwCtrl.dispose();
    _anim.dispose();
    super.dispose();
  }

  void _onChanged() {
    final text = _pwCtrl.text;
    final msg = PasswordValidator.nextRule(text); // returns first failing or null
    final passed = msg == null;
    if (passed != _allPassed) {
      // cadeado abrindo
      if (passed) _anim.forward(); else _anim.reverse();
    }
    setState(() {
      _nextRule = msg;
      _allPassed = passed;
    });

    if (_allPassed && !_isSaving) {
      _completeFlow();
    }
  }

  Future<void> _completeFlow() async {
    setState(() => _isSaving = true);
    final elapsed = DateTime.now().millisecondsSinceEpoch - _startMs;
    final seconds = (elapsed / 1000).round();

    // ask name
    final name = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final tc = TextEditingController();
        return AlertDialog(
          title: const Text('Você completou!'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Seu tempo: $seconds segundos'),
            const SizedBox(height: 10),
            TextField(controller: tc, decoration: const InputDecoration(hintText: 'Seu nome (aparecerá no ranking)')),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(null), child: const Text('Cancelar')),
            ElevatedButton(onPressed: () => Navigator.of(ctx).pop(tc.text.trim()), child: const Text('Salvar')),
          ],
        );
      },
    );

    if (name == null || name.isEmpty) {
      setState(() => _isSaving = false);
      return;
    }

    try {
      await _ranking.saveCompletion(name, seconds);
      if (!mounted) return;
      await showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Salvo!'), content: Text('Obrigado $name — tempo $seconds s salvo.'), actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))]));
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar ranking: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final next = _nextRule ?? 'Todas as regras cumpridas';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top minimal header (back small + title thin)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.of(context).pop()),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),

            // lock (center) with fade animation to swap images
            Expanded(
              child: Center(
                child: FadeTransition(
                  opacity: _fade,
                  child: Image.asset(
                    'assets/images/aberto.png',
                    width: 220,
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // show the closed lock behind fade (so reverse fades)
            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: Opacity(
                  opacity: 1.0 - _fade.value,
                  child: Center(
                    child: Image.asset(
                      'assets/images/fechado.png',
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // input and rule card area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _pwCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Digite sua senha',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                  const SizedBox(height: 14),

                  // rule card (next rule only)
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(_allPassed ? Icons.check_circle : Icons.info_outline, color: _allPassed ? Colors.green : Colors.indigo),
                          const SizedBox(width: 10),
                          Expanded(child: Text(next, style: TextStyle(fontSize: 15, color: _allPassed ? Colors.green[800] : Colors.black87))),
                        ],
                      ),
                    ),
                  ),

                  if (_isSaving) ...[
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
