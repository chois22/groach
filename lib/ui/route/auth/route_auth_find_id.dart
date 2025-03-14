import 'package:flutter/material.dart';
import 'package:practice1/ui/page/find/page_find_id_complete.dart';
import 'package:practice1/ui/page/find/page_find_id_confirm_email.dart';

class RouteAuthFindId extends StatefulWidget {
  const RouteAuthFindId({super.key});

  @override
  State<RouteAuthFindId> createState() => _RouteAuthFindIdState();
}

class _RouteAuthFindIdState extends State<RouteAuthFindId> {
  final PageController pageController = PageController();
  final ValueNotifier<int> vnIndexCurrent = ValueNotifier(0);
  final TextEditingController tecEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: vnIndexCurrent,
      builder: (context, indexCurrent, child) {
        print('-------------------');
        print(indexCurrent);
        print('-------------------');
        return PopScope(
          /// 0이 아닐 경우에만 뒤로 가기 가능, 0이 아니면 -1 이전 페이지 이동, 애니메이션 효과
          // canPop: indexCurrent == 0 ? true : false,
          // onPopInvokedWithResult: (didPop, result) {
          //   if (indexCurrent != 0) {
          //     pageController.animateToPage(indexCurrent - 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
          //   }
          // },
          child: Scaffold(
            body: SafeArea(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  vnIndexCurrent.value = value;
                },
                children: [
                  PageFindIdConfirmEmail(
                    pageController: pageController,
                    tecEmail: tecEmail,
                  ),
                  PageFindIdComplete(
                    pageController: pageController,
                    tecEmail: tecEmail,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
