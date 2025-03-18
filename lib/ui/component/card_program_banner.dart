import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';

// 배너 화면 card_swiper: ^3.0.1
class CardProgramBanner extends StatelessWidget {
  const CardProgramBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0XFFFFD26F), Color(0XFFFFF893)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.5),
                Text('그로치 회원님께만 드리는 쿠폰 혜택!', style: TS.s16w400(colorBlack)),
                const SizedBox(height: 11),
                Text('선착순 쿠폰 지급', style: TS.s24w700(colorBlack)),
                const SizedBox(height: 17),
                Container(
                  width: 121,
                  height: 29,
                  decoration: BoxDecoration(
                    color: Color(0XFFFFA647),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Color(0XFFFFA647), width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6, right: 16, left: 16),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('자세히 보러 가기', style: TS.s14w600(colorWhite), textAlign: TextAlign.center,)),
                  ),
                ),
                Text('                                       ㅡㅡㅡㅡㅡ'),
              ],
            ),
            //SvgPicture.asset('assets/image/banner_1.svg'),
            Gaps.h14,
            Image.asset('assets/image/banner_1.png'),
          ],
        ),
      ),
    );
  }
}

