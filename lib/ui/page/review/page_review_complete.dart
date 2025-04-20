import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/route/route_main.dart';

/// 리뷰 작성 완료 페이지
class PageReviewComplete extends StatelessWidget {
  final PageController pageController;

  const PageReviewComplete({
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Gaps.v16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RouteMain(),
                              ),
                            );
                          },
                          child: Icon(Icons.close, size: 24, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 131.5),
                    SvgPicture.asset('assets/image/complete.svg'),
                    Gaps.v10,
                    Text('리뷰가 작성되었어요!', style: TS.s24w700(colorGreen600)),
                    Gaps.v20,
                    Text(
                      '마이페이지에서 나의 리뷰 내역을\n확인하실 수 있어요.',
                      style: TS.s14w500(colorGray700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          //todo : 다음 버튼 위치 수정 완료
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RouteMain(),
                ),
              );
            },
            child: ButtonAnimate(
              title: '확인',
              colorBg: colorGreen600,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }
}
