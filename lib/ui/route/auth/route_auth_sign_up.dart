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
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {

      },
      child: Scaffold(
        //appBar: AppBar(automaticallyImplyLeading: false,),
        body: SafeArea(child: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PageSignUpUserInfo(
              pageController: pageController,
            ),
            //todo
            /// push로 이동해야되는데 오류나서 방법을 모르겠음.
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
  }
}