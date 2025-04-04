// 작은 사진 화면 flutter_staggered_grid_view: ^0.7.0
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';

class CardProgramGrid extends StatelessWidget {
  final int index;

  const CardProgramGrid({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> vnHeartTouch = ValueNotifier<bool>(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // 비율 설정
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                margin: EdgeInsets.only(right: 0),
                // 각 컨테이너 간 간격
                decoration: BoxDecoration(
                  color: Colors.teal[(index + 1) * 100], // 색상 변형
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Item $index',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: colorWhiteShadow60, // colorWhiteShadow60 대체
                  borderRadius: BorderRadius.circular(95),
                ),
                child: ValueListenableBuilder(
                  valueListenable: vnHeartTouch,
                  builder: (context, touch, child) {
                    return GestureDetector(
                      onTap: () {
                        vnHeartTouch.value = !vnHeartTouch.value;
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          touch
                              ? 'assets/icon/heart_red.svg' // 터치 시 빨간 하트
                              : 'assets/icon/heart_outline.svg', // 기본 상태
                          width: 24.0,
                          height: 24.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Gaps.v8,
        Text('프로그램명', style: TS.s13w500(colorGray600)),
        Text(
          '간단한 설명을 입력하는 칸입니다. 두줄까지 채워집니다.',
          style: TS.s13w500(colorGray600),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Image.asset('assets/icon/yellow_star.png', width: 16, height: 16),
            Text('4.5', style: TS.s13w500(colorGray800)),
            Gaps.h5,
            Text('수원 팔달구', style: TS.s13w500(colorGray500)),
          ],
        ),
        Row(
          children: [
            Text('37%', style: TS.s16w700(Color(0XFFFA7014))),
            Gaps.h2,
            Text('45,000', style: TS.s16w700(colorBlack)),
          ],
        ),
      ],
    );
  }
}
