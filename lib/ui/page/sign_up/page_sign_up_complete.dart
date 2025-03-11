import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/route/route_main.dart';

// 회원가입 완료 페이지
class PageSignUpComplete extends StatelessWidget {
  final PageController pageController;

  const PageSignUpComplete({required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
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
                  Text('가입이 완료되었어요!', style: TS.s24w700(colorGreen600)),
                  Gaps.v20,
                  Text(
                    '지금부터 그로치의 다양한 기능과 혜택을\n제공받을 수 있어요.',
                    style: TS.s14w500(colorGray700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 199.5),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (_) => RouteMain(),
                        ),
                      );
                    },
                    child: ButtonAnimate(
                      title: '다음',
                      colorBg: colorGreen600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
