// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:drop_go_smartphone/constants/constants.dart' as constants;
import 'package:drop_go_smartphone/features/event/presentation/home_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => const InfoScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 80,
              ),
              child: Column(
                children: [
                  const Text(
                    constants.overviewMsg,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    constants.getText,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Lottie.asset(
                    'assets/lottie/map.json',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).push(
                            HomeScreen.route(),
                          )
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4069FF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          constants.okText,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
