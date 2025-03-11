import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/component/custom_toast.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/page/find_id/page_find_id_confirm_email.dart';
import 'package:practice1/ui/route/auth/route_auth_sign_up.dart';
import 'package:practice1/utils/utils.dart';

class RouteAuthLogin extends StatefulWidget {
  const RouteAuthLogin({super.key});

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

  @override
  Widget build(BuildContext context) {
    tecEmail.addListener(() {
      vnFormCheckNotifier.value = tecEmail.text.isNotEmpty && tecPw.text.isNotEmpty;
    });
    tecPw.addListener(() {
      vnFormCheckNotifier.value = tecEmail.text.isNotEmpty && tecPw.text.isNotEmpty;
    });

    return GestureDetector(
      onTap: () {
        // 키보드 띄우고 바탕화면 누르면 나가기
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
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
                  ),
                ),

                Gaps.v26,

                /// 초록색 로그인 버튼
                GestureDetector(
                  onTap: () {
                    print('다음 버튼 터치');
                    Utils.toast(context: context, desc: 'test',toastGravity: ToastGravity.BOTTOM);
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
                            builder: (_) => PageFindIdConfirmEmail(),
                          ),
                        );
                      },
                      child: _TextContainer(loginAuthText: '아이디 찾기'),
                    ),
                    const Text('|', style: TS.s13w400(colorGray400)),

                    //todo: put sldkfj
                    /// 비밀번호 찾기
                    GestureDetector(
                      onTap: () {},
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
