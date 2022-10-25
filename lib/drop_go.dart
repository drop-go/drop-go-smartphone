import 'package:drop_go_smartphone/view/splash_screen.dart';
import 'package:flutter/material.dart';

class DropGo extends StatelessWidget {
  const DropGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
