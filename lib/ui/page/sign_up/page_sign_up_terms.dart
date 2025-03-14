import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/custom_appbar.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/route/route_terms.dart';

//todo
// 사용자 정보를 허용해주세요 페이지
class PageSignUpTerms extends StatefulWidget {
  final PageController pageController;

  const PageSignUpTerms({
    required this.pageController,
    super.key,
  });

  @override
  State<PageSignUpTerms> createState() => _PageSignUpTermsState();
}

class _PageSignUpTermsState extends State<PageSignUpTerms> {
  final ValueNotifier<bool> vnCheckBoxAll = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnCheckBoxTerm1 = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnCheckBoxTerm2 = ValueNotifier<bool>(false);
  final ValueNotifier<bool> vnCheckBoxTerm3 = ValueNotifier<bool>(false);

  // 체크박스 전체 or 선택 제외하고 버튼 활성화
  final ValueNotifier<bool> vnFormCheckNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    vnCheckBoxAll.addListener(_checkFormField);
    vnCheckBoxTerm1.addListener(_checkFormField);
    vnCheckBoxTerm2.addListener(_checkFormField);
    vnCheckBoxTerm3.addListener(_checkFormField);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {},
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbar(text: '회원가입'),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gaps.v20,
                        Text('사용자 정보를 허용해주세요.', style: TS.s20w600(colorBlack)),
                        Gaps.v6,
                        Text('앱의 사용을 위해 권한을 허용해주세요.', style: TS.s16w500(colorGray600)),
                        Gaps.v72,
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: vnCheckBoxAll,
                              builder: (context, check, child) {
                                return GestureDetector(
                                  onTap: () {
                                    bool allCheck = !vnCheckBoxAll.value;
                                    vnCheckBoxAll.value = allCheck;
                                    vnCheckBoxTerm1.value = allCheck;
                                    vnCheckBoxTerm2.value = allCheck;
                                    vnCheckBoxTerm3.value = allCheck;
                                  },
                                  child: SvgPicture.asset(
                                    check ? 'assets/icon/check-box_rectlagle.svg' : 'assets/icon/check-box_square.svg',
                                  ),
                                );
                              },
                            ),
                            Gaps.h10,
                            Text('약관 전체 동의', style: TS.s18w700(colorBlack)),
                          ],
                        ),
                        Gaps.v20,
                        CustomDivider(color: colorGray200),
                        Gaps.v20,
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: vnCheckBoxTerm1,
                              builder: (context, check, child) {
                                return GestureDetector(
                                  onTap: () {
                                    vnCheckBoxTerm1.value = !check;

                                    if (vnCheckBoxTerm1.value && vnCheckBoxTerm2.value && vnCheckBoxTerm3.value) {
                                      vnCheckBoxAll.value = true;
                                    } else {
                                      vnCheckBoxAll.value = false;
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    check ? 'assets/icon/check-box_rectlagle.svg' : 'assets/icon/check-box_square.svg',
                                  ),
                                );
                              },
                            ),
                            Gaps.h10,
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RouteTerms(
                                        title: '(필수) 이용약관 동의',
                                        vnCheckBoxTerm: vnCheckBoxTerm1,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('(필수) 이용약관 동의', style: TS.s16w400(colorBlack)),
                                    SvgPicture.asset('assets/icon/right_arrow.svg'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.5),
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: vnCheckBoxTerm2,
                              builder: (context, check, child) {
                                return GestureDetector(
                                  onTap: () {
                                    vnCheckBoxTerm2.value = !check;

                                    if (vnCheckBoxTerm1.value && vnCheckBoxTerm2.value && vnCheckBoxTerm3.value) {
                                      vnCheckBoxAll.value = true;
                                    } else {
                                      vnCheckBoxAll.value = false;
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    check ? 'assets/icon/check-box_rectlagle.svg' : 'assets/icon/check-box_square.svg',
                                  ),
                                );
                              },
                            ),
                            Gaps.h10,
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RouteTerms(
                                        title: '(필수) 개인정보 수집 및 이용 동의',
                                        vnCheckBoxTerm: vnCheckBoxTerm2,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('(필수) 개인정보 수집 및 이용 동의', style: TS.s16w400(colorBlack)),
                                    SvgPicture.asset('assets/icon/right_arrow.svg'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.5),
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: vnCheckBoxTerm3,
                              builder: (context, check, child) {
                                return GestureDetector(
                                  onTap: () {
                                    vnCheckBoxTerm3.value = !check;

                                    if (vnCheckBoxTerm1.value && vnCheckBoxTerm2.value && vnCheckBoxTerm3.value) {
                                      vnCheckBoxAll.value = true;
                                    } else {
                                      vnCheckBoxAll.value = false;
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    check ? 'assets/icon/check-box_rectlagle.svg' : 'assets/icon/check-box_square.svg',
                                  ),
                                );
                              },
                            ),
                            Gaps.h10,
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RouteTerms(
                                        title: '(선택) 개인정보 알람 및 주변 알람 동의',
                                        vnCheckBoxTerm: vnCheckBoxTerm3,
                                      ),
                                    ),
                                  ); //
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('(선택) 개인정보 알람 및 주변 알람 동의', style: TS.s16w400(colorBlack)),
                                    SvgPicture.asset('assets/icon/right_arrow.svg'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),

                  // todo: 푸시 팝 됐는데, 이상하게 동작함
                  ValueListenableBuilder<bool>(
                    valueListenable: vnFormCheckNotifier,
                    builder: (context, isFormCheck, child) {
                      return GestureDetector(
                        onTap: isFormCheck
                            ? () {
                                FocusManager.instance.primaryFocus?.unfocus();

                                widget.pageController.animateToPage(
                                  2,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              }
                            : null, // isFormCheck이 false면 아무 동작 없음
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
          ],
        ),
      ),
    );
  }

  void _checkFormField() {
    // 전체 동의가 되어있거나, 필수 약관들이 체크되었는지 확인
    bool isChecked =
        vnCheckBoxAll.value && (vnCheckBoxTerm1.value && vnCheckBoxTerm2.value) || (vnCheckBoxTerm1.value && vnCheckBoxTerm2.value);

    // 값 반영
    vnFormCheckNotifier.value = isChecked;
  }
}
