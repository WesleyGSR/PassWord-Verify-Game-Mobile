import 'package:flutter/material.dart';
import 'views/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WVPApp());
}

class WVPApp extends StatelessWidget {
  const WVPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassWord Verify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFCFDCF8),
      ),
      home: const SplashScreen(),
    );
  }
}
