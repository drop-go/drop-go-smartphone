import 'package:drop_go_smartphone/view/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:drop_go_smartphone/config/constants.dart' as constants;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    constants.eventInfo,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: InkWell(
                          onTap: () => {
                            Navigator.of(context).push(
                              MapScreen.route(),
                            ),
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 125,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Image.asset(
                                      "assets/image/nara.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "奈良県◯◯町",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          "君も大仏をゲット！！",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Text(
                                            "奈良県 ◯◯町にある大仏スポットを巡り、 そこでしか体験できない歴史を感じよう!!"),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          '◯◯月◯◯日 ~ ◯◯月◯◯日',
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
