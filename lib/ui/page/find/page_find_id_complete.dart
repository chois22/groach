import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/route/auth/route_auth_find_pw.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';
import 'package:practice1/ui/route/route_main.dart';

class PageFindIdComplete extends StatelessWidget {
  final PageController pageController;
  final TextEditingController tecEmail;

  const PageFindIdComplete({
    required this.pageController,
    required this.tecEmail,
    super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RouteAuthLogin(),
                      ),
                    );
                  },
                  child: Icon(Icons.close, size: 24, color: Colors.black),
                ),
              ],
            ),
          ),
          Gaps.v20,
          Text(
            '고객님 정보와 일치하는\n아이디에요.',
            style: TS.s20w600(colorBlack),
            textAlign: TextAlign.center,
          ),
          Gaps.v6,
          Gaps.v60,
          CustomDivider(color: colorGray200),
          Gaps.v2,
          Gaps.v16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tecEmail.text, style: TS.s18w500(colorBlack)),
              Text('2025.00.00 가입', style: TS.s16w400(colorGray600)),
            ],
          ),
          Gaps.v2,
          Gaps.v16,
          CustomDivider(color: colorGray200),

          Gaps.v2,
          Gaps.v48,
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RouteMain(),
                ),
              );
            },
            child: ButtonAnimate(
              title: '로그인 하러 가기',
              colorBg: colorGreen600,
              margin: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          Row(
            children: [
              Text('비밀번호가 기억나지 않는다면? ', style: TS.s14w400(colorGray600)),
              GestureDetector(
                onTap: (){
                  print('비밀번호 찾기로 이동!');
                  print('이메일 값은 ? ${tecEmail.text}');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (_) => RouteAuthFindPw(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text('PW찾기', style: TS.s14w400(colorGray600)),
                    SvgPicture.asset('assets/icon/right_arrow.svg'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
