import 'package:flutter/material.dart';
import 'package:practice1/ui/page/sign_up/page_sign_up_complete.dart';
import 'package:practice1/ui/page/sign_up/page_sign_up_terms.dart';
import 'package:practice1/ui/page/sign_up/page_sign_up_user_info.dart';

class RouteAuthSignUp extends StatefulWidget {
  const RouteAuthSignUp({super.key});

  @override
  State<RouteAuthSignUp> createState() => _RouteAuthSignUpState();
}


class _RouteAuthSignUpState extends State<RouteAuthSignUp> {
  final ValueNotifier<int> vnIndexCurrent = ValueNotifier(0);
  final PageController pageController = PageController();
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecName = TextEditingController();
  final TextEditingController tecNickName = TextEditingController();
  final TextEditingController tecPw = TextEditingController();
  final TextEditingController tecPwCheck = TextEditingController();

  // 이메일을 입력 했을 때, 중복확인 버튼 활성화
  final ValueNotifier<bool> vnIsEmailValidNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: vnIndexCurrent,
      builder: (context, indexCurrent, child) {
        print('-------------------');
        print(indexCurrent);
        print('-------------------');
        return PopScope(
          canPop:indexCurrent == 0 ?  true : false,
          onPopInvokedWithResult: (didPop, result) {
            if(indexCurrent != 0){
              pageController.animateToPage(indexCurrent-1, duration: Duration(milliseconds: 300), curve: Curves.linear);
            }
          },
          child: Scaffold(
            //appBar: AppBar(automaticallyImplyLeading: false,),
            body: SafeArea(child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                vnIndexCurrent.value=value;
              },
              // 회원가입 정보를 info, complete에 넘겨주기
              children: [
                PageSignUpUserInfo(
                  pageController: pageController,
                ),
                PageSignUpTerms(
                    pageController: pageController
                ),
                PageSignUpComplete(
                  pageController: pageController,
                ),
              ],
            ),),
          ),
        );
      },
    );
  }
}