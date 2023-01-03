// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'イベント情報',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.travel_explore),
          label: 'マップ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_open),
          label: 'ファイル一覧',
        ),
      ],
    );
  }
}
