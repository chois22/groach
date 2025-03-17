import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCheckText extends StatelessWidget {
  final String iconPath;
  final String message;
  final TextStyle textStyle;

  const InfoCheckText({
    required this.iconPath,
    required this.message,
    required this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: SvgPicture.asset(iconPath),
        ),
        Text(
          message, // 메시지 텍스트
          style: textStyle,
        ),
      ],
    );
  }
}
