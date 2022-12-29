// Flutter imports:
import 'package:flutter/material.dart';

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
