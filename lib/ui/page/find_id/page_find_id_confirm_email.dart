import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/button_confirm.dart';
import 'package:practice1/ui/component/textfield_default.dart';

class PageFindIdConfirmEmail extends StatefulWidget {
  const PageFindIdConfirmEmail({super.key});

  @override
  State<PageFindIdConfirmEmail> createState() => _PageFindIdConfirmEmailState();
}

class _PageFindIdConfirmEmailState extends State<PageFindIdConfirmEmail> {
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecVerificationCode = TextEditingController();
  final ValueNotifier<bool> vnIsEmailCheck = ValueNotifier<bool>(false);

  // 인증번호
  final ValueNotifier<bool> vnVerificationCode = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    tecEmail.addListener(() {
      String email = tecEmail.text;
      vnIsEmailCheck.value = email.isNotEmpty;
    });
  }

  @override
  void dispose() {
    tecEmail.dispose();
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
                                controller: tecEmail,
                                hintText: '이메일 입력',
                              ),
                            ),
                          ),
                          Gaps.h8,
                          ValueListenableBuilder<bool>(
                            valueListenable: vnIsEmailCheck,
                            builder: (context, isEmail, child) {
                              return ButtonConfirm(
                                boxText: '인증요청',
                                textStyle: TS.s16w500(isEmail ? colorWhite : colorGray500),
                                boxColor: isEmail ? colorGreen600 : colorGray200,
                                width: 87,
                                height: 48,
                                onTap: () {
                                  String email = tecEmail.text;
                                  if (email.isNotEmpty) {
                                    print('인증요청');
                                    vnVerificationCode.value = true;
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Gaps.v10,
                      ValueListenableBuilder<bool>(
                        valueListenable: vnVerificationCode,
                        builder: (context, showSecondTextField, child) {
                          return showSecondTextField
                              ? TextFieldDefault(
                                  controller: tecVerificationCode,
                                  hintText: '인증번호 입력',
                                )
                              : SizedBox(); // showSecondTextField
                        },
                      ),
                      const SizedBox(height: 418),
                      ButtonAnimate(
                        title: '다음',
                        colorBg: colorGreen600,
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
