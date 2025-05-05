import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/key.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/button_confirm.dart';
import 'package:practice1/ui/component/custom_appbar.dart';
import 'package:practice1/ui/component/custom_toast.dart';
import 'package:practice1/ui/component/info_check_text.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/dialog/dialog_confirm.dart';
import 'package:practice1/utils/utils.dart';
import 'package:practice1/utils/utils_enum.dart';

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

  // 닉네임 중복 확인
  final ValueNotifier<bool> vnIsNickNameCheck = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnTecNickNameMatch = ValueNotifier<bool>(false);

  // 이메일, 닉네임 중복확인 시 출력 메세지
  final ValueNotifier<String?> vnEmailErrorMessage = ValueNotifier(null);
  final ValueNotifier<String?> vnNickNameErrorMessage = ValueNotifier(null);

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
    widget.tecNickName.addListener(() {
      vnTecNickNameMatch.value = widget.tecNickName.text.isNotEmpty;
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

                    /// ---------------------------- 이메일 부분 시작----------------------------
                    ///
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
                                  onChanged: (value) {
                                    vnEmailErrorMessage.value = null;
                                  },
                                ),
                              ),
                            ),
                            Gaps.h8,
                            ValueListenableBuilder(
                              valueListenable: vnIsEmailCheck,
                              builder: (context, isEmailCheck, child) => ValueListenableBuilder(
                                valueListenable: vnTecEmailMatch,
                                builder: (context, isEmail, child) {
                                  return ButtonConfirm(
                                    boxText: isEmailCheck ? '확인완료' : '중복확인',
                                    textStyle: TS.s16w500(
                                      isEmailCheck
                                          ? colorGray500
                                          : isEmail
                                              ? colorWhite
                                              : colorGray500,
                                    ),
                                    boxColor: isEmailCheck
                                        ? colorGray200
                                        : isEmail
                                            ? colorGreen600
                                            : colorGray200,
                                    width: 87,
                                    height: 48,
                                    onTap: () async {
                                      String email = widget.tecEmail.text.trim();

                                      /// 이메일 입력 안했을 때 return
                                      if (email.isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogConfirm(
                                            text: UtilsEnum.getSignUpMessage(SignUpMessage.Empty_Email),
                                          ),
                                        );

                                        vnEmailErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Empty_Email);
                                        return;
                                      }

                                      /// 이메일 형식이 아닐 때 return
                                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                      if (!emailRegex.hasMatch(email)) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogConfirm(
                                            text: UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_Email),
                                          ),
                                        );
                                        vnEmailErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_Email);

                                        return;
                                      }

                                      final resultEmail =
                                          await FirebaseFirestore.instance.collection(keyUser).where(keyEmail, isEqualTo: email).get();

                                      /// 이메일이 중복일 때 return
                                      if (resultEmail.docs.isNotEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogConfirm(
                                            text: UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_Email),
                                          ),
                                        );
                                        vnEmailErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_Email);

                                        return;
                                      }

                                      //todo: 여기 이렇게 하는 거 아닌듯. 물어보기.
                                      /// 중복확인 통과
                                      if (isEmailCheck && resultEmail.docs.isEmpty) {}
                                      vnIsEmailCheck.value = true;
                                      vnTecEmailMatch.value = true;
                                      vnEmailErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Possible_Email);
                                      _checkFormField();

                                      showDialog(
                                        context: context,
                                        builder: (context) => DialogConfirm(
                                          text: UtilsEnum.getSignUpMessage(SignUpMessage.Possible_Email),
                                        ),
                                      );

                                      return;

                                      /// 하드코딩 예시
                                      // 이메일이 입력되었을 때만 체크
                                      // if (email != 'test@naver.com') {
                                      //   // 이메일이 사용 가능하면
                                      //   vnTecEmailMatch.value = true; // 유효한 이메일
                                      // } else {
                                      //   // 이메일이 이미 사용 중이면
                                      //   vnTecEmailMatch.value = false; // 유효하지 않은 이메일
                                      // }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        /// 이메일 사용 가능, 불가능 체크 텍스트
                        ValueListenableBuilder(
                          valueListenable: vnEmailErrorMessage,
                          builder: (context, errorMessage, child) {
                            return ValueListenableBuilder(
                              valueListenable: vnTecEmailMatch,
                              builder: (context, isTecEmailMatch, child) {
                                /// 이메일을 입력해주세요.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Empty_Email)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/!_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Empty_Email),
                                    textStyle: TS.s12w500(Color(0XFFD4380D)),
                                  );
                                }

                                /// 잘못된 이메일 형식입니다.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_Email)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/!_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_Email),
                                    textStyle: TS.s12w500(Color(0XFFD4380D)),
                                  );
                                }

                                /// 사용중인 이메일입니다.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_Email)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/!_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_Email),
                                    textStyle: TS.s12w500(Color(0XFFD4380D)),
                                  );
                                }

                                /// 사용 가능한 이메일입니다.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Possible_Email)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/v_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Possible_Email),
                                    textStyle: TS.s12w500(colorGreen500),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    /// ---------------------------- 이메일 부분 끝----------------------------
                    ///
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

                    ///
                    /// ---------------------------- 닉네임 부분 시작----------------------------
                    ///
                    Text('닉네임', style: TS.s14w500(colorGray700)),
                    Gaps.v8,
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextFieldDefault(
                                  controller: widget.tecNickName,
                                  hintText: '닉네임 입력',
                                  onChanged: (value) {
                                    vnNickNameErrorMessage.value = null;
                                  },
                                ),
                              ),
                            ),
                            Gaps.h8,
                            ValueListenableBuilder(
                              valueListenable: vnIsNickNameCheck,
                              builder: (context, isNickNameCheck, child) => ValueListenableBuilder(
                                valueListenable: vnTecNickNameMatch,
                                builder: (context, isNickName, child) {
                                  return ButtonConfirm(
                                    boxText: isNickNameCheck ? '확인완료' : '중복확인',
                                    textStyle: TS.s16w500(
                                      isNickNameCheck
                                          ? colorGray500
                                          : isNickName
                                              ? colorWhite
                                              : colorGray500,
                                    ),
                                    boxColor: isNickNameCheck
                                        ? colorGray200
                                        : isNickName
                                            ? colorGreen600
                                            : colorGray200,
                                    width: 87,
                                    height: 48,
                                    onTap: () async {
                                      String nickName = widget.tecNickName.text.trim();

                                      /// 닉네임 입력 안했을 때 return
                                      if (nickName.isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogConfirm(
                                            text: UtilsEnum.getSignUpMessage(SignUpMessage.Empty_NickName),
                                          ),
                                        );
                                        vnNickNameErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Empty_NickName);
                                        return;
                                      }

                                      /// 닉네임 형식이 아닐 때 return(한글, 숫자, 영어, 대문자만 가능하게)
                                      /// 특수문자는 사용할 수 없습니다.
                                      final nicknameRegex = RegExp(r'^[A-Za-z0-9가-힣]+$');

                                      if (!nicknameRegex.hasMatch(nickName)) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogConfirm(
                                            text: UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_NickName),
                                          ),
                                        );
                                        vnNickNameErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_NickName);

                                        return;
                                      }

                                      final resultNickName = await FirebaseFirestore.instance
                                          .collection(keyUser)
                                          .where(keyNickName, isEqualTo: nickName)
                                          .get();

                                      /// 이메일이 중복일 때 return
                                      if (resultNickName.docs.isNotEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => DialogConfirm(
                                            text: UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_NickName),
                                          ),
                                        );
                                        vnNickNameErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_NickName);

                                        return;
                                      }

                                      //todo: 여기 이렇게 하는 거 아닌듯. 물어보기.
                                      /// 중복확인 통과
                                      if (isNickNameCheck && resultNickName.docs.isEmpty) {}
                                      vnIsNickNameCheck.value = true;
                                      vnTecNickNameMatch.value = true;
                                      vnNickNameErrorMessage.value = UtilsEnum.getSignUpMessage(SignUpMessage.Possible_NickName);
                                      _checkFormField();

                                      showDialog(
                                        context: context,
                                        builder: (context) => DialogConfirm(
                                          text: UtilsEnum.getSignUpMessage(SignUpMessage.Possible_NickName),
                                        ),
                                      );

                                      return;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        /// 닉네임 사용 가능, 불가능 체크 텍스트
                        ValueListenableBuilder(
                          valueListenable: vnNickNameErrorMessage,
                          builder: (context, errorMessage, child) {
                            return ValueListenableBuilder(
                              valueListenable: vnTecNickNameMatch,
                              builder: (context, isTecNickNameMatch, child) {
                                /// 닉네임을 입력해주세요.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Empty_NickName)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/!_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Empty_NickName),
                                    textStyle: TS.s12w500(Color(0XFFD4380D)),
                                  );
                                }

                                /// 잘못된 닉네임 형식입니다.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_NickName)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/!_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_NickName),
                                    textStyle: TS.s12w500(Color(0XFFD4380D)),
                                  );
                                }

                                /// 사용중인 닉네임입니다.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_NickName)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/!_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Duplicate_NickName),
                                    textStyle: TS.s12w500(Color(0XFFD4380D)),
                                  );
                                }

                                /// 사용 가능한 닉네임입니다.
                                if (errorMessage == UtilsEnum.getSignUpMessage(SignUpMessage.Possible_NickName)) {
                                  return InfoCheckText(
                                    iconPath: 'assets/icon/v_icon.svg',
                                    message: UtilsEnum.getSignUpMessage(SignUpMessage.Possible_NickName),
                                    textStyle: TS.s12w500(colorGreen500),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    ///
                    /// ---------------------------- 닉네임 부분 끝----------------------------
                    ///
                    Gaps.v20,
                    Text('비밀번호', style: TS.s14w500(colorGray700)),
                    Gaps.v8,
                    SizedBox(
                      height: 48,
                      child: TextFieldDefault(
                        controller: widget.tecPw,
                        hintText: '비밀번호 입력',
                        obscureText: true, // 비밀번호 ***표시
                        onChanged: (passwordText) {
                          final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()\-_=+{};:,<.>]).{8,}$');
                          final pwCheck = widget.tecPwCheck.text;

                          /// 비밀번호 입력을 안했을 때
                          if (passwordText.isEmpty) {
                            vnStatusOfPw.value = StatusOfPw.none;
                            return;
                          }

                          /// 8자 미만, 대문자, 특수문자 포함 안된 때
                          if (!passwordRegex.hasMatch(passwordText)) {
                            vnStatusOfPw.value = StatusOfPw.Invalid_Pw;
                            return;
                          }

                          /// 비밀번호 확인 텍스트 적었을 때
                          if (pwCheck.isEmpty) {
                            vnStatusOfPw.value = StatusOfPw.none;
                            return;
                          }

                          /// tecPw == tecPwCheck 비밀번호 일치할 때
                          if (passwordText == pwCheck) {
                            vnStatusOfPw.value = StatusOfPw.match;
                          }

                          /// 일치하지 않을 때
                          else {
                            vnStatusOfPw.value = StatusOfPw.not_match;
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
                        onChanged: (passwordText) {
                          final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()\-_=+{};:,<.>]).{8,}$');
                          final pwCheck = widget.tecPwCheck.text;

                          /// 비밀번호 입력을 안했을 때
                          if (passwordText.isEmpty) {
                            vnStatusOfPw.value = StatusOfPw.none;
                            return;
                          }

                          /// 8자 미만, 대문자, 특수문자 포함 안된 때
                          if (!passwordRegex.hasMatch(passwordText)) {
                            vnStatusOfPw.value = StatusOfPw.Invalid_Pw;
                            return;
                          }

                          /// 비밀번호 확인 텍스트 적었을 때
                          if (pwCheck.isEmpty) {
                            vnStatusOfPw.value = StatusOfPw.none;
                            return;
                          }

                          /// tecPw == tecPwCheck 비밀번호 일치할 때
                          if (passwordText == pwCheck) {
                            vnStatusOfPw.value = StatusOfPw.match;
                          }

                          /// 일치하지 않을 때
                          else {
                            vnStatusOfPw.value = StatusOfPw.not_match;
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

                          /// 일치하지 않을 때
                        } else if (statusOfPw == StatusOfPw.not_match) {
                          return InfoCheckText(
                            iconPath: 'assets/icon/!_icon.svg',
                            message: '비밀번호가 일치하지 않습니다.',
                            textStyle: TS.s12w500(Color(0XFFD4380D)),
                          );

                          /// 8자 미만, 대문자, 특수문자가 포함되지 않았을 때
                        } else {
                          return InfoCheckText(
                            iconPath: 'assets/icon/!_icon.svg',
                            message: '8자 이상, 대문자, 특수문자를 포함해주세요.',
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
                  onTap: () {
                    /// 이름은 한글로만 입력하는 정규
                    final nameRegex = RegExp(r'^[가-힣]+$');
                    String name = widget.tecName.text.trim();
                    String nickName = widget.tecName.text.trim();

                    /// 이름을 입력해주세요.
                    if (name.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogConfirm(
                          text: UtilsEnum.getSignUpMessage(SignUpMessage.Empty_Name),
                        ),
                      );
                      return;
                    }

                    if (!nameRegex.hasMatch(name)) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogConfirm(
                          text: UtilsEnum.getSignUpMessage(SignUpMessage.Invalid_Name),
                        ),
                      );
                      return;
                    }

                    /// 닉네임을 입력해주세요.
                    if (nickName.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogConfirm(
                          text: UtilsEnum.getSignUpMessage(SignUpMessage.Empty_NickName),
                        ),
                      );
                      return;
                    }

                    if (vnStatusOfPw.value == StatusOfPw.none) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogConfirm(
                          text: '비밀번호를 입력해주세요.',
                        ),
                      );
                      return;
                    }

                    if (vnStatusOfPw.value == StatusOfPw.not_match) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogConfirm(
                          text: '비밀번호를 확인해주세요.',
                        ),
                      );
                      return;
                    }

                    if (vnIsEmailCheck.value == false) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogConfirm(
                          text: '이메일 중복확인을 해주세요.',
                        ),
                      );
                      return;
                    }

                    if (vnIsNickNameCheck.value == false) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogConfirm(
                          text: '닉네임 중복확인을 해주세요.',
                        ),
                      );
                      return;
                    }

                    FocusManager.instance.primaryFocus?.unfocus();

                    widget.pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                  },
                  child: ButtonAnimate(
                    title: '다음',
                    colorBg: isFormCheck ? colorGreen600 : colorGray500,
                    margin: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
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
        widget.tecPwCheck.text.isNotEmpty &&
        vnIsEmailCheck.value == true &&
        vnIsNickNameCheck.value == true;

    vnFormCheck.value = isCheck;
  }
}
