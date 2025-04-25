import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/route/route_main.dart';

/// 리뷰 작성 완료 페이지
class RouteReviewComplete extends StatelessWidget {
  const RouteReviewComplete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          /// 페이지 전체 칼럼
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 가운데 로고, 내용
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

              /// 확인 버튼
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
        ),
      ),
    );
  }
}
