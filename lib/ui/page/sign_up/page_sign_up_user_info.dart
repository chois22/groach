import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/button_confirm.dart';
import 'package:practice1/ui/component/custom_appbar.dart';
import 'package:practice1/ui/component/custom_toast.dart';
import 'package:practice1/ui/component/info_check_text.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/dialog/dialog_confirm.dart';
import 'package:practice1/ui/dialog/dialog_show.dart';
import 'package:practice1/utils/utils.dart';

class PageSignUpUserInfo extends StatefulWidget {
  final PageController pageController;
  final TextEditingController tecEmail;
  final TextEditingController tecName;
  final TextEditingController tecNickName;
  final TextEditingController tecPw;
  final TextEditingController tecPwCheck;

  const PageSignUpUserInfo({
    required this.pageController,
    required this.tecEmail,
    required this.tecName,
    required this.tecNickName,
    required this.tecPw,
    required this.tecPwCheck,
    super.key,
  });

  @override
  State<PageSignUpUserInfo> createState() => _PageSignUpUserInfoState();
}

class _PageSignUpUserInfoState extends State<PageSignUpUserInfo> {
  // enum을 이용한 비밀번호 체크
  final ValueNotifier<StatusOfPw> vnStatusOfPw = ValueNotifier(StatusOfPw.none);

  // 이메일을 입력 했을 때, 중복확인 버튼 활성화
  final ValueNotifier<bool> vnIsEmailCheck = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnTecEmailMatch = ValueNotifier<bool>(false);

  // 빈칸이 없을 때 다음 버튼 활성화
  final ValueNotifier<bool> vnFormCheck = ValueNotifier<bool>(false);

  void _resetEmailStatus() {
    vnIsEmailCheck.value = false;
    vnTecEmailMatch.value = false;
  }

  @override
  void initState() {
    super.initState();
    widget.tecEmail.addListener(() {
      String email = widget.tecEmail.text;

      // 이메일 수정시 자동으로 상태를 갱신하지 않도록 해야 하므로,
      // '중복확인' 버튼을 다시 눌러야만 상태가 갱신되도록 설정
      if (email.isEmpty) {
        _resetEmailStatus(); // 이메일이 비었으면 상태 리셋
      } else {}
    });
  }

//todo : vn들 dispose 추가
  @override
  void dispose() {
    widget.tecEmail.dispose();
    widget.tecName.dispose();
    widget.tecNickName.dispose();
    widget.tecPw.dispose();
    widget.tecPwCheck.dispose();

    vnIsEmailCheck.dispose();
    vnTecEmailMatch.dispose();
    vnFormCheck.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.tecEmail.addListener(() {
      vnTecEmailMatch.value = widget.tecEmail.text.isNotEmpty;
    });
    widget.tecName.addListener(_checkFormField);
    widget.tecNickName.addListener(_checkFormField);
    widget.tecPw.addListener(_checkFormField);
    widget.tecPwCheck.addListener(_checkFormField);

    // Scaffold랑 Appbar 지우기
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomAppbar(text: '회원가입'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v20,
                    Text('회원가입 정보 입력', style: TS.s20w600(colorBlack)),
                    Gaps.v10,
                    Text('로그인에 사용될 가입 정보를 입력해주세요.', style: TS.s16w500(colorGray600)),
                    Gaps.v42,
                    Text('이메일', style: TS.s14w500(colorGray700)),
                    Gaps.v8,

                    /// 이메일 텍스트필드 및 중복확인
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextFieldDefault(
                                  controller: widget.tecEmail,
                                  hintText: '이메일 입력',
                                ),
                              ),
                            ),
                            Gaps.h8,
                            ValueListenableBuilder(
                              valueListenable: vnTecEmailMatch,
                              builder: (context, isEmail, child) {
                                return ButtonConfirm(
                                  boxText: '중복확인',
                                  textStyle: TS.s16w500(isEmail ? colorWhite : colorGray500),
                                  boxColor: isEmail ? colorGreen600 : colorGray200,
                                  width: 87,
                                  height: 48,
                                  onTap: () {
                                    String email = widget.tecEmail.text;
                                    if (email.isNotEmpty) {
                                      // 이메일이 입력되었을 때만 체크
                                      if (email == 'test@naver.com') {
                                        // 이메일이 사용 가능하면
                                        vnTecEmailMatch.value = true; // 유효한 이메일
                                      } else {
                                        // 이메일이 이미 사용 중이면
                                        vnTecEmailMatch.value = false; // 유효하지 않은 이메일
                                      }
                                      vnIsEmailCheck.value = true;
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                        /// 이메일 사용 가능, 불가능 체크 텍스트
                        ValueListenableBuilder(
                          valueListenable: vnIsEmailCheck, // 중복확인 버튼을 눌렀는지 여부 확인
                          builder: (context, isChecked, child) {
                            // 중복확인 버튼을 눌렀을 때만 메시지 표시
                            if (!isChecked) {
                              return SizedBox.shrink(); // 중복확인 버튼을 누르지 않으면 아무것도 표시되지 않음
                            }

                            return ValueListenableBuilder(
                              valueListenable: vnTecEmailMatch, // 이메일 유효성 체크 상태
                              builder: (context, isTecEmailMatch, child) {
                                if (isTecEmailMatch) {
                                  // 이메일이 사용 가능할 때
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/v_icon.svg',
                                    message: '사용 가능한 이메일 입니다.',
                                    textStyle: TS.s12w500(colorGreen500),
                                  );
                                } else {
                                  // 이메일이 사용 중일 때, 중복확인 상태를 리셋

                                  return InfoCheckText(
                                    iconPath: 'assets/icon/!_icon.svg',
                                    message: '사용중인 이메일 입니다.',
                                    textStyle: TS.s12w500(Color(0XFFD4380D)),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    Gaps.v20,
                    Text('이름', style: TS.s14w500(colorGray700)),
                    Gaps.v8,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: widget.tecName,
                        hintText: '이름 입력',
                      ),
                    ),
                    Gaps.v20,
                    Text('닉네임', style: TS.s14w500(colorGray700)),
                    Gaps.v8,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: widget.tecNickName,
                        hintText: '닉네임 입력',
                      ),
                    ),
                    Gaps.v20,
                    Text('비밀번호', style: TS.s14w500(colorGray700)),
                    Gaps.v8,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: widget.tecPw,
                        hintText: '비밀번호 입력',
                        obscureText: true, // 비밀번호 ***표시
                        onChanged: (text) {
                          /// 비밀번호가 비어있을 때
                          if (text.isEmpty) {
                            vnStatusOfPw.value = StatusOfPw.none;

                            /// 텍스트 적었을 때
                          } else {
                            if (widget.tecPwCheck.text.isEmpty) {
                              vnStatusOfPw.value = StatusOfPw.none;
                              return;
                            }

                            /// tecPw == tecPwCheck
                            if (text == widget.tecPwCheck.text) {
                              vnStatusOfPw.value = StatusOfPw.match;
                            }

                            /// 일치하지 않을 때
                            else {
                              vnStatusOfPw.value = StatusOfPw.not_match;
                            }
                          }
                        },
                      ),
                    ),
                    Gaps.v8,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: widget.tecPwCheck,
                        hintText: '비밀번호 재입력',
                        obscureText: true,
                        onChanged: (text) {
                          if (text.isEmpty) {
                            vnStatusOfPw.value = StatusOfPw.none;

                            /// 텍스트 적었을 때
                          } else {
                            if (widget.tecPw.text.isEmpty) {
                              vnStatusOfPw.value = StatusOfPw.none;
                              return;
                            }

                            /// tecPw == tecPwCheck
                            if (text == widget.tecPw.text) {
                              vnStatusOfPw.value = StatusOfPw.match;
                            }

                            /// 일치하지 않을 때
                            else {
                              vnStatusOfPw.value = StatusOfPw.not_match;
                            }
                          }
                        },
                      ),
                    ),
                    Gaps.v10,
                    // 비밀번호 체크
                    ValueListenableBuilder<StatusOfPw>(
                      valueListenable: vnStatusOfPw,
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
            ValueListenableBuilder<bool>(
              valueListenable: vnFormCheck,
              builder: (context, isFormCheck, child) {
                return GestureDetector(
                  onTap: () async {
                    if (widget.tecEmail.text.isEmpty) {
                      Utils.toast(context: context, desc: '이메일을 입력해주세요.');
                      return;
                    }
                    if (widget.tecName.text.isEmpty) {
                      Utils.toast(context: context, desc: '이름을 입력해주세요.');
                      return;
                    }
                    if (widget.tecNickName.text.isEmpty) {
                      Utils.toast(context: context, desc: '닉네임을 입력해주세요.');
                      return;
                    }
                    // if(vnStatusOfPw.value == StatusOfPw.none){
                    //   Utils.toast(context: context, desc: '비밀번호를 입력해주세요.');
                    //   return;
                    // }
                    // if(vnStatusOfPw.value == StatusOfPw.not_match){
                    //   Utils.toast(context: context, desc: '비밀번호를 확인해주세요.');
                    //   return;
                    // }
                    if (vnStatusOfPw.value == StatusOfPw.none) {
                      await DialogShow2.showDialogLine2(context, '비밀번호를 입력해주세요.비밀번호를 입력해주세요.');
                      return;
                    }

                    if (vnStatusOfPw.value == StatusOfPw.not_match) {
                      await DialogShow1.showDialogLine1(context, '비밀번호를 확인해주세요.');
                      return;
                    }
                    FocusManager.instance.primaryFocus?.unfocus();

                    widget.pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                  },
                  child: ButtonAnimate(
                    title: '다음',
                    colorBg: isFormCheck ? colorGreen600 : colorGray500,
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 모든 칸이 입력됐는지 확인하는 변수
  void _checkFormField() {
    bool isCheck = widget.tecName.text.isNotEmpty &&
        widget.tecNickName.text.isNotEmpty &&
        widget.tecPw.text.isNotEmpty &&
        widget.tecPwCheck.text.isNotEmpty;

    vnFormCheck.value = isCheck;
  }
}
