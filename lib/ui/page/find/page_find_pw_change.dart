import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/enum.dart';
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

  final ValueNotifier<StatusOfPw> vnStatusOfPW = ValueNotifier(StatusOfPw.none);

/*  @override
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
  }*/

  @override
  Widget build(BuildContext context) {
/*    tecPw.addListener(_checkFormField);
    tecPwCheck.addListener(_checkFormField);*/

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
                        onChanged: (text) {
                          /// 비밀번호가 비어있을 때
                          if (text.isEmpty) {
                            vnStatusOfPW.value = StatusOfPw.none;

                            /// 텍스트 적었을 때
                          } else {
                            if (tecPwCheck.text.isEmpty) {
                              vnStatusOfPW.value = StatusOfPw.none;
                              return;
                            }

                            /// tecPw == tecPwCheck
                            if (text == tecPwCheck.text) {
                              vnStatusOfPW.value = StatusOfPw.match;
                            }

                            /// 일치하지 않을 때
                            else {
                              vnStatusOfPW.value = StatusOfPw.not_match;
                            }
                          }
                        },
                      ),
                    ),
                    Gaps.v10,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: tecPwCheck,
                        hintText: '비밀번호 입력',
                        obscureText: true,
                        onChanged: (text) {
                          if (text.isEmpty) {
                            vnStatusOfPW.value = StatusOfPw.none;

                            /// 텍스트 적었을 때
                          } else {
                            if (tecPw.text.isEmpty) {
                              vnStatusOfPW.value = StatusOfPw.none;
                              return;
                            }

                            /// tecPw == tecPwCheck
                            if (text == tecPw.text) {
                              vnStatusOfPW.value = StatusOfPw.match;
                            }

                            /// 일치하지 않을 때
                            else {
                              vnStatusOfPW.value = StatusOfPw.not_match;
                            }
                          }
                        },
                      ),
                    ),
                    Gaps.v10,
                    ValueListenableBuilder(
                      valueListenable: vnStatusOfPW,
                      builder: (context, statusOfPw, child) {
                        /// 아무것도 안보여줌
                        if (statusOfPw == StatusOfPw.none) {
                          return SizedBox.shrink();

                          /// 일치 할 때
                        } else if (statusOfPw == StatusOfPw.match) {
                          return InfoCheckText(
                            iconPath: 'assets/icon/v_icon.svg',
                            message: '비밀번호가 일치합니다.',
                            textStyle: TS.s12w500(colorGreen500),
                          );

                          /// 일치핮지 않을 때
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
            ValueListenableBuilder<StatusOfPw>(
              valueListenable: vnStatusOfPW,
              builder: (context, statusOfPw, child) {
                return GestureDetector(
                  onTap: statusOfPw == StatusOfPw.match
                      ? () {
                          FocusManager.instance.primaryFocus?.unfocus();

                          Utils.toast(
                            context: context,
                            desc: '비밀번호를 다시 확인해주세요.',
                            toastGravity: ToastGravity.CENTER,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RouteAuthLogin(), // 값을 전달
                            ),
                          );
                        }
                      : () {
                          /// 매치 아닐때
                          if (statusOfPw == StatusOfPw.none) {
                            Utils.toast(
                              context: context,
                              desc: '비밀번호를 입력해주세요.',
                              toastGravity: ToastGravity.TOP,
                            );
                          } else {
                            Utils.toast(
                              context: context,
                              desc: '비밀번호가 일치하지 않습니다.',
                              toastGravity: ToastGravity.CENTER,
                            );
                          }
                        },
                  child: ButtonAnimate(
                    title: '다음',
                    colorBg: statusOfPw == StatusOfPw.match ? colorGreen600 : colorGray500,
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
}
