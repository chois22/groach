import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';

// 이용약관 나와있는 페이지 // > 눌러서 오는 페이지
class RouteTerms extends StatefulWidget {
  final String title;
  final ValueNotifier<bool> vnCheckBoxTerm;

  const RouteTerms({
    required this.title,
    required this.vnCheckBoxTerm,
    super.key,
  });

  @override
  State<RouteTerms> createState() => _RouteTermsState();
}

class _RouteTermsState extends State<RouteTerms> {

  @override
  Widget build(BuildContext context) {

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
              Text(widget.title, style: TS.s16w500(colorBlack)),
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
                    valueListenable: widget.vnCheckBoxTerm,
                    builder: (context, check, child) {
                      return GestureDetector(
                        onTap: () {
                          widget.vnCheckBoxTerm.value = !widget.vnCheckBoxTerm.value;
                        },
                        child: SvgPicture.asset(
                          check ? 'assets/icon/check-box_rectlagle.svg' : 'assets/icon/check-box_square.svg',
                        ),
                      );
                    },
                  ),
                  Gaps.h10,
                  Text(widget.title, style: TS.s16w400(colorBlack)),
                ],
              ),
              const SizedBox(height: 13),
              ValueListenableBuilder<bool>(
                valueListenable: widget.vnCheckBoxTerm,
                builder: (context, isFormCheck, child) {
                  print("isFormCheck: $isFormCheck");
                  return GestureDetector(
                    onTap: isFormCheck
                        ? () {
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: ButtonAnimate(
                      title: '확인',
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

}
