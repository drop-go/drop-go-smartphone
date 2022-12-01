import 'package:drop_go_smartphone/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: avoid_print
      ref.read(routerProvider).push('/info');
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
                  'GO',
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
