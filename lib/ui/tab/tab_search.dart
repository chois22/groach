import 'package:flutter/material.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/component/textfield_search.dart';
import 'package:practice1/ui/page/search/search_found.dart';
import 'package:practice1/ui/page/search/search_main.dart';
import 'package:practice1/ui/page/search/search_not_found.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({super.key});

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  final ValueNotifier<int> vnIndexCurrent = ValueNotifier(0);
  final PageController pageController = PageController();
  final TextEditingController tecSearch = TextEditingController();

  Widget build(BuildContext context) {
    return Column(
      children: [
        /// appbar (textfield),
        Container(),
        SizedBox(
          height: 42,
          child: Stack(
            children: [
              TextFieldSearch(
                hintText: '검색어를 입력해주세요',
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 42,
                  color: Colors.transparent,
                  child: Center(
                    child: Icon(Icons.add),
                  ),
                ),
              )

            ],
          ),
        ),

        /// Expande Singe
      ],
    );

    return ValueListenableBuilder(
      valueListenable: vnIndexCurrent,
      builder: (context, indexCurrent, child) {
        return PopScope(
          /// 0이 아닐 경우에만 뒤로 가기 가능, 0이 아니면 -1 이전 페이지 이동, 애니메이션 효과
          canPop: indexCurrent == 0 ? true : false,
          onPopInvokedWithResult: (didPop, result) {
            if (indexCurrent != 0) {
              pageController.animateToPage(indexCurrent - 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  vnIndexCurrent.value = value;
                },
                children: [
                  SearchMain(
                    pageController: pageController,
                    tecSearch: tecSearch,
                  ),
                  SearchFound(
                    pageController: pageController,
                    tecSearch: tecSearch,
                  ),
                  SearchNotFound(
                    pageController: pageController,
                    tecSearch: tecSearch,
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
