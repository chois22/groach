import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';

/// 테두리 색상도 넣기
class ButtonAnimate extends StatelessWidget {
  final String title;
  final Color colorBg; //backgroud 배경색
  final EdgeInsetsGeometry? margin;
  final void Function()? onTap;

  const ButtonAnimate({
    required this.title,
    required this.colorBg,
    this.margin,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: margin,
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: colorBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: TS.s18w600(colorWhite),
          ),
        ),
      ),
    );
  }
}
