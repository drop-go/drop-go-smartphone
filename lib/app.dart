// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';

// Project imports:
import 'package:drop_go_smartphone/features/introduction/presentation/splash_screen.dart';
import 'package:drop_go_smartphone/main.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF4069FF),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
      navigatorKey: navigatorKey,
    );
  }
}
