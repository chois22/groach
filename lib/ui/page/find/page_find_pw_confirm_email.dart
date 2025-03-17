import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/button_confirm.dart';
import 'package:practice1/ui/component/custom_appbar.dart';
import 'package:practice1/ui/component/info_check_text.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'dart:async';

class PageFindPwConfirmEmail extends StatefulWidget {
  final PageController pageController;
  final TextEditingController tecEmail;

  const PageFindPwConfirmEmail({
    required this.pageController,
    required this.tecEmail,
    super.key,
  });

  @override
  State<PageFindPwConfirmEmail> createState() => _PageFindPwConfirmEmailState();
}

class _PageFindPwConfirmEmailState extends State<PageFindPwConfirmEmail> {
  final TextEditingController tecConfirmNumber = TextEditingController();
  final ValueNotifier<bool> vnIsEmailCheck = ValueNotifier<bool>(false);

  // 인증번호
  final ValueNotifier<bool> vnConfirmNumber = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnNumberMatch = ValueNotifier<bool>(false);
  final ValueNotifier<String> vnMatchMessage = ValueNotifier<String>('');

  final ValueNotifier<String> vnRequestButtonText = ValueNotifier<String>('인증요청');

  // 타이머 컨트롤러
  _TimerPeriodicState? timerController;

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomAppbar(text: '비밀번호 찾기'),
            Expanded(
              child: SingleChildScrollView(
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
                            // 이메일 입력되면 인증요청 활성화, 인증번호 입력 창 활성화
                            ValueListenableBuilder<String>(
                              valueListenable: vnRequestButtonText,
                              builder: (context, btnText, child) {
                                return ValueListenableBuilder<bool>(
                                  valueListenable: vnIsEmailCheck,
                                  builder: (context, isEmail, child) {
                                    return ButtonConfirm(
                                      /// 시간 오버 되면 재요청으로 변경
                                      boxText: btnText,
                                      textStyle: TS.s16w500(isEmail ? colorWhite : colorGray500),
                                      boxColor: isEmail ? colorGreen600 : colorGray200,
                                      width: 87,
                                      height: 48,
                                      onTap: () {
                                        String email = widget.tecEmail.text;
                                        if (email.isNotEmpty) {
                                          vnConfirmNumber.value = true;
                                          timerController?.startTimer();
                                        }
                                      },
                                    );
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
                                Stack(
                                  children: [
                                    TextFieldDefault(
                                      controller: tecConfirmNumber,
                                      hintText: '인증번호 입력',
                                      onChanged: (text) {
                                        /// 임시 비밀번호
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
                                    // 3분 타이머
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: _TimerPeriodic(
                                        vnRequestButtonText: vnRequestButtonText,
                                        onInitController: (controller) => timerController = controller,
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v8,
                                ValueListenableBuilder<String>(
                                  valueListenable: vnMatchMessage,
                                  builder: (context, message, child) {
                                    return message.isNotEmpty
                                        ? InfoCheckText(
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
                    margin: EdgeInsets.symmetric(vertical: 16),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}

// 인증요청 타이머
class _TimerPeriodic extends StatefulWidget {
  final ValueNotifier<String> vnRequestButtonText;
  final Function(_TimerPeriodicState controller) onInitController;

  const _TimerPeriodic({
    required this.vnRequestButtonText,
    required this.onInitController,
    super.key,
  });

  @override
  State<_TimerPeriodic> createState() => _TimerPeriodicState();
}

class _TimerPeriodicState extends State<_TimerPeriodic> {
  final ValueNotifier<int> remainingSeconds = ValueNotifier<int>(180);

  // final ValueNotifier<String> vnRequestButtonText = ValueNotifier<String>('인증요청');
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
    widget.onInitController(this);
  }

  /// 타이머 시작
  void startTimer() {
    _timer?.cancel(); // 기존 타이머 취소
    remainingSeconds.value = 180; // 3분 리셋

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value == 0) {
        timer.cancel(); // 0초 되면 멈춤
        widget.vnRequestButtonText.value = '재요청';
      } else {
        remainingSeconds.value--;
      }
    });
  }

  /// 시간 포맷 (분:초)
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = sec.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _timer?.cancel(); // 페이지 나갈 때 타이머 정지 (메모리 누수 방지)
    remainingSeconds.dispose(); // ValueNotifier dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: remainingSeconds,
      builder: (context, value, child) {
        return value == 180 // 타이머 시작 전에는 숨기기
            ? SizedBox.shrink()
            : Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: Colors.white,
          child: Text(
            formatTime(value),
            style: TS.s16w400(colorRed), // 스타일 설정
          ),
        );
      },
    );
  }
}
