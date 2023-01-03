// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:drop_go_smartphone/app.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 端末の向きを固定する
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
}
