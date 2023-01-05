// Flutter imports:
import 'package:flutter/material.dart';

class OtherPreview extends StatelessWidget {
  const OtherPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            const Center(
              child: Text('このファイルはプレビュー対象外です'),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: FloatingActionButton(
                  heroTag: "close",
                  backgroundColor: Colors.white.withOpacity(0.5),
                  elevation: 0,
                  onPressed: () => Navigator.of(context).pop(),
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
