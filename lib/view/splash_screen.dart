import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Spacer(),
              Text(
                'GO',
                style: GoogleFonts.notoSans(
                  fontSize: 100,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF073375),
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
