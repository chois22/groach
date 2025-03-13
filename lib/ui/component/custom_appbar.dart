import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';

class CustomAppbar extends StatelessWidget {
  final String text;

  const CustomAppbar({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        children: [
          // 가운데 텍스트
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TS.s18w600(colorBlack),
            ),
          ),
          // 왼쪽 아이콘
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset('assets/icon/left_arrow.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
