// 작은 사진 화면 flutter_staggered_grid_view: ^0.7.0
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';

class CardProgramScroll extends StatelessWidget {
  final int index;
  final double width;
  final double height;

  const CardProgramScroll({
    required this.index,
    this.width = 125,
    this.height = 125,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> vnHeartTouch = ValueNotifier<bool>(false);

    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: width,
                // 각 컨테이너의 너비
                height: height,
                // 각 컨테이너의 높이
                //margin: EdgeInsets.only(right: 10),
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
              Positioned(
                top: 13,
                right: 8,
                child: Container(
                  height: 32,
                  width: 32,
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
                            width: 19.2,
                            height: 19.2,
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
          Text('간단한 설명을 입력하는 칸입니다.', style: TS.s13w500(colorGray600)),
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
      ),
    );
  }
}
