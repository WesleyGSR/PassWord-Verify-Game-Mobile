import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});
  final String _rules = '''
1) A senha deve conter pelo menos 8 caracteres.
2) Deve conter pelo menos um número.
3) Deve conter um caractere especial.
4) Deve conter pelo menos uma letra MAIÚSCULA.
5) A soma de todos os números deve ser igual a 24 (4!).
6) Deve conter um dia da semana (ex: segunda-feira).
7) Deve conter o decimal do binário 0011 (3).
8) Deve conter um número romano (I,V,X,L,C,D,M).
9) Deve conter VA (Vaticano).
10) Todos os números devem ser da sequência Fibonacci (1,2,3,5,8).
11) Deve conter a letra L.
12) Soma dos números romanos deve ser 191.
13) Deve conter IFCE.
14) Regra especial, a senha deve conter os criadores.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.of(context).pop()), title: const Text('Regras', style: TextStyle(color: Colors.black87))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_rules, style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87)),
          ),
        ),
      ),
    );
  }
}
