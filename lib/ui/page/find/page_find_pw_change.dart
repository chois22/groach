
import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/custom_appbar.dart';
import 'package:practice1/ui/component/custom_toast.dart';
import 'package:practice1/ui/component/info_check_text.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';
import 'package:practice1/utils/utils.dart';

class PageFindPwChange extends StatefulWidget {
  const PageFindPwChange({super.key});

  @override
  State<PageFindPwChange> createState() => _PageFindPwChangeState();
}

class _PageFindPwChangeState extends State<PageFindPwChange> {
  final TextEditingController tecPw = TextEditingController();
  final TextEditingController tecPwCheck = TextEditingController();

  // 비밀번호 매칭 확인용
  final ValueNotifier<bool> vnTecPwMatch = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnFormCheckNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    tecPw.addListener(_checkPasswordMatch);
    tecPwCheck.addListener(_checkPasswordMatch);
    _checkPasswordMatch();
    super.initState();
  }
  @override
  void dispose() {
    tecPw.dispose();
    tecPwCheck.dispose();
    tecPw.removeListener(_checkPasswordMatch);
    tecPwCheck.removeListener(_checkPasswordMatch);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   tecPw.addListener(_checkFormField);
   tecPwCheck.addListener(_checkFormField);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(text: '비밀번호 찾기'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v40,
                    Text('비밀번호 변경', style: TS.s20w600(colorBlack)),
                    Gaps.v6,
                    Text('새로운 비밀번호를 입력해주세요.', style: TS.s16w500(colorGray600)),
                    Gaps.v42,
                    Text('비밀번호', style: TS.s16w500(colorGray600)),
                    Gaps.v10,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: tecPw,
                        hintText: '비밀번호 입력',
                        obscureText: true,
                      ),
                    ),
                    Gaps.v10,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: tecPwCheck,
                        hintText: '비밀번호 입력',
                        obscureText: true,
                      ),
                    ),
                    Gaps.v10,
                    ValueListenableBuilder<bool>(
                      valueListenable: vnTecPwMatch,
                      builder: (context, pwMatch, child) {
                        if (tecPw.text.isEmpty && tecPwCheck.text.isEmpty) {
                          return SizedBox.shrink(); // 아무것도 표시하지 않음
                        }
                        if (pwMatch) {
                          return InfoCheckText(
                            iconPath: 'assets/icon/v_icon.svg',
                            message: '비밀번호가 일치합니다.',
                            textStyle: TS.s12w500(colorGreen500),
                          );
                        } else {
                          return InfoCheckText(
                            iconPath: 'assets/icon/!_icon.svg',
                            message: '비밀번호가 일치하지 않습니다.',
                            textStyle: TS.s12w500(Color(0XFFD4380D)),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: vnFormCheckNotifier,
              builder: (context, isFormCheck, child) {
                bool isPwMatch = tecPw.text == tecPwCheck.text;
                bool isAllFormCheck = tecPw.text.isNotEmpty && tecPwCheck.text.isNotEmpty;
                bool canActivateButton = isFormCheck && isPwMatch && isAllFormCheck;

                return GestureDetector(
                  onTap: canActivateButton
                      ? () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    bool isPwChange = true;  // 이 조건이 충족될 때만 로그인 화면에 값 전달

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RouteAuthLogin(isPwChange: isPwChange), // 값을 전달
                      ),
                    );
                  }
                      : () {
                    // isFormCheck이 false일 때, 버튼을 누를 수 없으므로 Toast 띄우기
                    Utils.toast(
                      context: context,
                      desc: '비밀번호를 다시 확인해주세요.',
                      toastGravity: ToastGravity.CENTER,
                    );
                  },
                  child: ButtonAnimate(
                    title: '다음',
                    colorBg: isFormCheck ? colorGreen600 : colorGray500,
                    margin: EdgeInsets.symmetric(vertical: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  void _checkPasswordMatch() {
    bool isMatch = tecPw.text == tecPwCheck.text;
    vnTecPwMatch.value = isMatch;
  }

// 모든 칸이 입력됐는지 확인하는 변수
  void _checkFormField() {
    bool isAllCheck = tecPw.text.isNotEmpty && tecPwCheck.text.isNotEmpty;
    bool isMatch = tecPw.text == tecPwCheck.text;

    vnTecPwMatch.value = isMatch;

    // 두 조건 모두 만족할 때만 true
    vnFormCheckNotifier.value = isAllCheck && isMatch;
  }
}

