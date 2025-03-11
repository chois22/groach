import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';

class BottomIconButton extends StatelessWidget {
  const BottomIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icon/kakao.svg',),

        CircleContainer(
          IconName: 'assets/icon/Google.svg',
          selectColor: colorWhite,
          borderColor: colorGray200,
          borderWidth: 1,
        ),
        const SizedBox(width: 16),
        CircleContainer(
          IconName: 'assets/icon/kakao.svg',
          selectColor: Color(0xFFF7E317),
          borderColor: Color(0xFFF7E317),
          borderWidth: 1,
          iconHeight: 26,
          iconWidth: 26,
        ),
        const SizedBox(width: 16),
        CircleContainer(
          IconName: 'assets/icon/naver.svg',
          selectColor: Color(0xFF03C75A),
          borderColor: colorGray500,
          borderWidth: 1,
        ),
        const SizedBox(width: 16),
        CircleContainer(
          IconName: 'assets/icon/Apple.svg',
          selectColor: colorGray900,
          borderColor: colorGray500,
          borderWidth: 1,
          iconHeight: 26,
          iconWidth: 26,
        ),
      ],
    );
  }
}

class CircleContainer extends StatelessWidget {
  final String IconName;
  final Color borderColor;
  final Color selectColor;
  final double borderWidth;
  final double iconWidth;
  final double iconHeight;

  const CircleContainer({
    required this.IconName,
    required this.borderColor,
    required this.borderWidth,
    required this.selectColor,
    this.iconWidth = 26,
    this.iconHeight = 26,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: selectColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Center(
        child: Image.asset(
          IconName,
          width: iconWidth,
          height: iconHeight,
        ),
      ),
    );
  }
}
