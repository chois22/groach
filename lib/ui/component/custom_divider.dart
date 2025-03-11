import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final double height;
  final Color color;

  const CustomDivider({
    super.key,
    this.height=1,
    required this.color,
    this.margin=EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: height,
      color: color,
    );
  }
}
