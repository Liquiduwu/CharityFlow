import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/splash_screen.dart';
import './theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const CharityFlowApp());
}

class CharityFlowApp extends StatelessWidget {
  const CharityFlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.getTheme(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
