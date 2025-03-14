import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/button_confirm.dart';
import 'package:practice1/ui/component/info_check_text.dart';
import 'package:practice1/ui/component/textfield_default.dart';

class PageFindIdConfirmEmail extends StatefulWidget {
  final PageController pageController;
  final TextEditingController tecEmail;

  const PageFindIdConfirmEmail({
    required this.pageController,
    required this.tecEmail,
    super.key,
  });

  @override
  State<PageFindIdConfirmEmail> createState() => _PageFindIdConfirmEmailState();
}

class _PageFindIdConfirmEmailState extends State<PageFindIdConfirmEmail> {
  final TextEditingController tecConfirmNumber = TextEditingController();
  final ValueNotifier<bool> vnIsEmailCheck = ValueNotifier<bool>(false);

  // 인증번호
  final ValueNotifier<bool> vnConfirmNumber = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnNumberMatch = ValueNotifier<bool>(false);
  final ValueNotifier<String> vnMatchMessage = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    widget.tecEmail.addListener(() {
      String email = widget.tecEmail.text;
      vnIsEmailCheck.value = email.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.tecEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('아이디 찾기', style: TS.s18w600(colorBlack)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v40,
                        Text('이메일 인증', style: TS.s20w600(colorBlack)),
                        Gaps.v6,
                        Text('아이디 찾기에 필요한 이메일 인증을 진행해주세요.', style: TS.s16w500(colorGray600)),
                        Gaps.v42,
                        Text('이메일', style: TS.s16w500(colorGray600)),
                        Gaps.v10,
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
                                ValueListenableBuilder<bool>(
                                  valueListenable: vnIsEmailCheck,
                                  builder: (context, isEmail, child) {
                                    return ButtonConfirm(
                                      /// 시간 오버 되면 재요청으로 변경
                                      boxText: '인증요청',
                                      textStyle: TS.s16w500(isEmail ? colorWhite : colorGray500),
                                      boxColor: isEmail ? colorGreen600 : colorGray200,
                                      width: 87,
                                      height: 48,
                                      onTap: () {
                                        String email = widget.tecEmail.text;
                                        if (email.isNotEmpty) {
                                          vnConfirmNumber.value = true;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Gaps.v10,

                            /// 시간초는 Stack으로 넣기, timer periodic 사용하기
                            ValueListenableBuilder<bool>(
                              valueListenable: vnConfirmNumber,
                              builder: (context, showSecondTextField, child) {
                                return showSecondTextField
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextFieldDefault(
                                            controller: tecConfirmNumber,
                                            hintText: '인증번호 입력',
                                            onChanged: (text) {
                                              String serverVerificationCode = '1234';
                                              if (text.isEmpty) {
                                                vnMatchMessage.value = ''; // 입력이 없으면 메시지 비우기
                                                vnNumberMatch.value = false; // 일치 여부 초기화
                                              } else if (text == serverVerificationCode) {
                                                vnNumberMatch.value = true;
                                                vnMatchMessage.value = '인증번호가 일치합니다.';
                                              } else {
                                                vnNumberMatch.value = false;
                                                vnMatchMessage.value = '인증번호가 일치하지 않습니다.';
                                              }
                                            },
                                          ),
                                          Gaps.v8,
                                          ValueListenableBuilder<String>(
                                            valueListenable: vnMatchMessage,
                                            builder: (context, message, child) {
                                              return message.isNotEmpty
                                                  ? Infochecktext(
                                                      iconPath: vnNumberMatch.value ? 'assets/icon/v_icon.svg' : 'assets/icon/!_icon.svg',
                                                      message: message,
                                                      textStyle: TS.s12w500(vnNumberMatch.value ? colorGreen500 : Color(0XFFD4380D)),
                                                    )
                                                  : SizedBox();
                                            },
                                          ),
                                        ],
                                      )
                                    : SizedBox(); // showSecondTextField // showSecondTextField
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  print('---------------------');
                  print('이메일 값은 ? ${widget.tecEmail.text}');
                  print('---------------------');
                  widget.pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
                child: ValueListenableBuilder(
                  valueListenable: vnNumberMatch,
                  builder: (context, check, child) {
                    return ButtonAnimate(
                      title: '다음',
                      colorBg: check ? colorGreen600 : colorGray500,
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
