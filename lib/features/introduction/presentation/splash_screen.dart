// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:drop_go_smartphone/constants/constants.dart' as constants;
import 'package:drop_go_smartphone/features/event/presentation/home_screen.dart';
import 'package:drop_go_smartphone/features/introduction/presentation/info_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('hasLaunchedInitial') == null) {
        await prefs.setBool('hasLaunchedInitial', true);

        if (!mounted) return;
        Navigator.of(context).push(
          InfoScreen.route(),
        );
      }

      if (!mounted) return;
      Navigator.of(context).push(
        HomeScreen.route(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  constants.goText,
                  style: GoogleFonts.notoSans(
                    fontSize: 100,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073375),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 1, minHeight: 1),
                    child: Lottie.asset(
                      'assets/lottie/splash.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
