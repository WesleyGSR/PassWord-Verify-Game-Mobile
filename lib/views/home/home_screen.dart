import 'package:flutter/material.dart';
import '../game/game_screen.dart';
import '../ranking/ranking_screen.dart';
import '../settings/settings_screen.dart';
import '../info/rules_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // grande espaço para ícone
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/fechado.png', // imagem exemplo no centro
                  width: 260,
                  height: 260,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // botões maiores alinhados com margem lateral
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // largura disponível total
                  final totalWidth = constraints.maxWidth;

                  // queremos 4 botões + 3 espaços entre eles
                  // espaço entre botões = 12px (pode ajustar)
                  const spacing = 12.0;
                  const buttons = 4;

                  // calcula automaticamente o tamanho máximo possível
                  final buttonSize = (totalWidth - (spacing * (buttons - 1))) / buttons;

                  // mantém limites mínimos e máximos para visual bonito
                  final size = buttonSize.clamp(60.0, 84.0);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _bigButton(
                        size: size,
                        color: const Color(0xFF47D447),
                        icon: Icons.play_arrow,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GameScreen()),
                        ),
                      ),
                      _bigButton(
                        size: size,
                        color: const Color(0xFF90A8F8),
                        icon: Icons.settings,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        ),
                      ),
                      _bigButton(
                        size: size,
                        color: const Color(0xFF90A8F8),
                        icon: Icons.info_outline,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RulesScreen()),
                        ),
                      ),
                      _bigButton(
                        size: size,
                        color: const Color(0xFFB28BFF),
                        icon: Icons.leaderboard,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RankingScreen()),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),


            // rodapé "password"
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'password',
                style: TextStyle(fontSize: 24, color: Colors.black54, letterSpacing: 1.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bigButton({
    required double size,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size * 0.22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: size * 0.45,
          color: Colors.black87,
        ),
      ),
    );
  }

}
