import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/page/sign_up/page_sign_up_complete.dart';

// 이용약관 나와있는 페이지 // > 눌러서 오는 페이지
class RouteTerms extends StatefulWidget {
  final PageController pageController;

  const RouteTerms({
    required this.pageController,
    super.key,
  });

  @override
  State<RouteTerms> createState() => _RouteTermsState();
}

class _RouteTermsState extends State<RouteTerms> {
  final ValueNotifier<bool> vnCheckBoxTerm1 = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    vnCheckBoxTerm1.addListener(_checkFormField);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v16,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, size: 24, color: Colors.black),
                  ),
                ],
              ),
              Gaps.v16,
              //todo maxline 물어보기
              Text('(필수) 이용약관 동의', style: TS.s16w500(colorBlack)),
              Gaps.v16,
              Center(
                child: Container(
                  width: double.infinity,
                  height: 512,
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorGray400),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            '약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. \n하단에 약관 내용을 쭉 입력해주시면 됩니다. \n\n약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. \n\n하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. 약관동의에 대한 내용입니다. 하단에 약관 내용을 쭉 입력해주시면 됩니다. ',
                            style: TS.s14w400(colorBlack),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 27,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.v20,
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: vnCheckBoxTerm1,
                    builder: (context, check, child) {
                      return GestureDetector(
                        onTap: () {
                          vnCheckBoxTerm1.value = !vnCheckBoxTerm1.value;
                        },
                        child: SvgPicture.asset(
                          check ? 'assets/icon/check-box_rectlagle.svg' : 'assets/icon/check-box_square.svg',
                        ),
                      );
                    },
                  ),
                  Gaps.h10,
                  Text('(선택) 개인정보 알람 및 주변 알람 동의', style: TS.s16w400(colorBlack)),
                ],
              ),
              const SizedBox(height: 13),
              ValueListenableBuilder<bool>(
                valueListenable: vnCheckBoxTerm1,
                builder: (context, isFormCheck, child) {
                  print("isFormCheck: $isFormCheck");
                  return GestureDetector(
                    onTap: isFormCheck
                        ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PageSignUpComplete(
                            pageController: widget.pageController,
                          ),
                        ),
                      );
                    }

                    /*{
                      // 여기서 페이지 이동을 시도하기 전에 pageController가 null이 아닌지 다시 한 번 확인
                      print("animateToPage 호출됨");
                      widget.pageController.animateToPage(
                        2,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    }*/
                        : null,
                    child: ButtonAnimate(
                      title: '다음',
                      colorBg: isFormCheck ? colorGreen600 : colorGray500,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkFormField() {
    // 전체 동의가 되어있거나, 필수 약관들이 체크되었는지 확인
    bool isChecked = vnCheckBoxTerm1.value;

    // 값 반영
    vnCheckBoxTerm1.value = isChecked;
  }
}
