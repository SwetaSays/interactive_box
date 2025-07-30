import 'package:flutter/material.dart';
import 'package:interactive_box/config/app_config.dart';

class CBox extends StatelessWidget {
  final int index;
  final double boxSize;
  final bool isGreen;
  final Function(int) onTap;

  const CBox({
    super.key,
    required this.index,
    required this.boxSize,
    required this.isGreen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: AppConfig.animationDuration,
        margin: const EdgeInsets.all(AppConfig.boxSpacing / 2),
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: isGreen ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(AppConfig.boxBorderRadius),
        ),
      ),
    );
  }
}
