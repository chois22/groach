import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/model/model_user.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/key.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/dialog/dialog_confirm.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';
import 'package:practice1/ui/route/route_main.dart';
import 'package:practice1/ui/route/route_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// 회원가입 완료 페이지
class PageSignUpComplete extends StatelessWidget {
  final PageController pageController;
  final TextEditingController tecEmail;
  final TextEditingController tecName;
  final TextEditingController tecNickName;
  final TextEditingController tecPw;
  final TextEditingController tecPwCheck;

  const PageSignUpComplete({
    required this.pageController,
    required this.tecEmail,
    required this.tecName,
    required this.tecNickName,
    required this.tecPw,
    required this.tecPwCheck,
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
                    Text('가입이 완료되었어요!', style: TS.s24w700(colorGreen600)),
                    Gaps.v20,
                    Text(
                      '지금부터 그로치의 다양한 기능과 혜택을\n제공받을 수 있어요.',
                      style: TS.s14w500(colorGray700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///  회원가입 정보 firebase에 넘겨주기
          GestureDetector(
            onTap: () async {
              final modelUser = ModelUser(
                uid: Uuid().v1(),
                dateCreate: Timestamp.now(),
                email: tecEmail.text.trim(),
                name: tecName.text.trim(),
                nickname: tecNickName.text.trim(),
                pw: tecPw.text.trim(),
              );
              // print('입력된 이메일은 ?: ${tecEmail.text}');
              // print('입력된 이름은 ?: ${tecName.text}');
              // print('입력된 닉네임은 ?: ${tecNickName.text}');
              // print('입력된 비밀번호는 ?: ${tecPw.text}');
              // print('입력된 비밀번호 확인은 ?: ${tecPwCheck.text}');

              await FirebaseFirestore.instance.collection(keyUser).doc(modelUser.uid).set(modelUser.toJson());

              final spf  = await SharedPreferences.getInstance();

              await spf.setString(keyUid, modelUser.uid);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => RouteSplash(),
                ),
                (route) => false,
              );
            },
            child: ButtonAnimate(
              title: '메인 페이지로 이동',
              colorBg: colorGreen600,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }
}
