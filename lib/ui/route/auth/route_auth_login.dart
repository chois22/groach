import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/component/custom_toast.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/dialog/dialog_cancel_confirm.dart';
import 'package:practice1/ui/dialog/dialog_confirm.dart';
import 'package:practice1/ui/route/auth/route_auth_find_id.dart';
import 'package:practice1/ui/route/auth/route_auth_find_pw.dart';
import 'package:practice1/ui/route/auth/route_auth_sign_up.dart';
import 'package:practice1/ui/route/route_main.dart';
import 'package:practice1/utils/utils.dart';

class RouteAuthLogin extends StatefulWidget {
  const RouteAuthLogin({
    super.key,
  });

  @override
  State<RouteAuthLogin> createState() => _RouteAuthLoginState();
}

class _RouteAuthLoginState extends State<RouteAuthLogin> {
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPw = TextEditingController();
  final ValueNotifier<bool> vnAuthLogin = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnFormCheckNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    tecEmail.dispose();
    tecPw.dispose();
    super.dispose();
  }

  Future<bool> _userInfoCheck(String email, String pw) async {
    try {
      final QuerySnapshot userInfo = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      Utils.log.f('이메일 "$email" 로 검색된 문서 수: ${userInfo.docs.length}개');
      if (userInfo.docs.isEmpty) {
        return false; // 이메일 없음
      }

      for (final doc in userInfo.docs) {
        final userPw = doc['pw'];
        final userUid = doc['uid'];
        Utils.log.f('저장된 비밀번호: $userPw');
        Utils.log.f('입력된 비밀번호: $pw');
        Utils.log.f('UID: $userUid');

        if (userPw == pw) {
          Utils.log.f('비밀번호 일치');
          return true;
        } else {
          Utils.log.f('비밀번호 불일치');
        }
      }

      return false; // 이메일은 있지만 비밀번호 다 틀림
    } catch (e) {
      Utils.log.f('에러 발생: $e');
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    tecEmail.addListener(() {
      vnFormCheckNotifier.value = tecEmail.text.isNotEmpty && tecPw.text.isNotEmpty;
    });
    tecPw.addListener(() {
      vnFormCheckNotifier.value = tecEmail.text.isNotEmpty && tecPw.text.isNotEmpty;
    });

    /// 로그인 화면에서 뒤로가기 눌렀을 때 앱 종료 문구 출력 (취소: 머물기, 확인: 앱 종료)
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => DialogCancelConfirm(
              text: '앱을 종료하시겠습니까?',
            ),
          );
          if (result == true) {
            SystemNavigator.pop();
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          // 키보드 띄우고 바탕화면 누르면 나가기
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            // 앱바 화살표 표시 없애기
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gaps.v36,
                  Center(child: Image.asset('assets/image/sub logo.png', height: 160, width: 160)),
                  Gaps.v40,

                  /// email
                  SizedBox(
                    height: 48,
                    child: TextFieldDefault(
                      controller: tecEmail,
                      hintText: '이메일 입력',
                    ),
                  ),
                  Gaps.v10,
                  SizedBox(
                    height: 48,
                    child: TextFieldDefault(
                      controller: tecPw,
                      hintText: '비밀번호 입력',
                      obscureText: true,
                    ),
                  ),

                  Gaps.v26,

                  /// 초록색 로그인 버튼
                  GestureDetector(
                    onTap: () async {
                      final email = tecEmail.text.trim();
                      final pw = tecPw.text.trim();

                      if (email.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => DialogConfirm(text: '이메을 입력해주세요.'),
                        );
                        return;
                      }
                      if (pw.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => DialogConfirm(text: '비밀번호를 입력해주세요.'),
                        );
                        return;
                      }
                     bool isUserValid = await _userInfoCheck(email, pw);

                      if (isUserValid) {
                        // 로그인 성공 시 화면 전환 (RouteMain으로 이동)
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RouteMain(),
                          ),
                        );
                      } else {
                        // 로그인 실패 시 다이얼로그 표시
                        showDialog(
                          context: context,
                          builder: (context) => DialogConfirm(text: '이메일, 비밀번호를 확인해주세요.'),
                        );
                      }
                    },
                    child: ValueListenableBuilder<bool>(
                      valueListenable: vnFormCheckNotifier,
                      builder: (context, isFormCheck, child) {
                        return ButtonAnimate(
                          title: '로그인',
                          colorBg: colorGreen600,
                          //todo
                          /// 나중에 아무 값도 입력 안됐을 때, 이메일, 비밀번호를 입력해 주세요 출력 넣기.
                          //colorBg: isFormCheck ? colorGreen600 : colorGray500,
                        );
                      },
                    ),
                  ),
                  Gaps.v16,

                  /// 아이디 찾기, 비밀번호 찾기, 회원가입
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 아이디 찾기
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RouteAuthFindId(),
                            ),
                          );
                        },
                        child: _TextContainer(loginAuthText: '아이디 찾기'),
                      ),
                      const Text('|', style: TS.s13w400(colorGray400)),

                      //todo: put sldkfj
                      /// 비밀번호 찾기
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RouteAuthFindPw(),
                            ),
                          );
                        },
                        child: _TextContainer(loginAuthText: '비밀번호 찾기'),
                      ),
                      const Text('|', style: TS.s13w400(colorGray400)),

                      /// 회원가입
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RouteAuthSignUp(),
                            ),
                          );
                        },
                        child: _TextContainer(
                          loginAuthText: '회원가입',
                        ),
                      ),
                    ],
                  ),

                  Gaps.v64,

                  /// ----- 또는 -----
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gaps.v16,
                      Expanded(child: CustomDivider(color: colorGray400, margin: EdgeInsets.symmetric(horizontal: 20))),
                      Container(
                        color: Colors.transparent,
                        child: Text('또는', style: TextStyle(color: colorGray600, fontSize: 13)),
                      ),
                      Expanded(child: CustomDivider(color: colorGray400, margin: EdgeInsets.symmetric(horizontal: 20))),
                      Gaps.v16,
                    ],
                  ),
                  Gaps.v20,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleContainer(
                        iconName: 'assets/icon/Google.svg',
                        selectColor: colorWhite,
                        borderColor: colorGray200,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RouteAuthSignUp(),
                          ));
                        },
                      ),
                      Gaps.h16,
                      CircleContainer(
                        iconName: 'assets/icon/kakao.svg',
                        selectColor: const Color(0xFFF7E317),
                        onTap: () {},
                      ),
                      Gaps.h16,
                      CircleContainer(
                        iconName: 'assets/icon/naver.svg',
                        selectColor: Color(0xFF03C75A),
                        onTap: () {},
                      ),
                      Gaps.h16,
                      CircleContainer(
                        iconName: 'assets/icon/Apple.svg',
                        selectColor: colorGray900,
                        onTap: () {},
                      ),
                    ],
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

class CircleContainer extends StatelessWidget {
  final String iconName;
  final Color? borderColor;
  final Color selectColor;
  final void Function()? onTap;

  const CircleContainer({
    required this.iconName,
    this.borderColor,
    required this.selectColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: selectColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: borderColor == null ? selectColor : borderColor!,
            width: 1,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconName,
          ),
        ),
      ),
    );
  }
}

class _TextContainer extends StatelessWidget {
  final String loginAuthText;

  const _TextContainer({required this.loginAuthText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.transparent,
      child: Text(
        loginAuthText,
        style: TS.s13w400(colorGray600),
        textAlign: TextAlign.center,
      ),
    );
  }
}
