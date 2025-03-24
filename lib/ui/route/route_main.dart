import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/ui/tab/tab_home.dart';
import 'package:practice1/ui/tab/tab_my.dart';
import 'package:practice1/ui/tab/tab_search.dart';

//todo: kjw : bottom navigation bar 만들기(complete)
// pop안되도록 설정하기

class RouteMain extends StatefulWidget {
  const RouteMain({super.key});

  @override
  State<RouteMain> createState() => _RouteMainState();
}

class _RouteMainState extends State<RouteMain> {
  final ValueNotifier<int> vnIndexTab = ValueNotifier(0);
  List<String> listIcons = [
    'assets/icon/home_outline.svg',
    'assets/icon/search_outline.svg',
    'assets/icon/my_outline.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          //todo : 이거 높이 이걸로 하면 ... 사이즈 초과함..
          //height: kBottomNavigationBarHeight,
          //color: colorGray200,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: colorGray200, width: 1),
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: vnIndexTab,
            builder: (context, index, child) {
              return BottomNavigationBar(
                currentIndex: index,
                onTap: (tabIndex) {
                  vnIndexTab.value = tabIndex;
                },
                selectedItemColor: colorGreen600,
                unselectedItemColor: colorGray500,
                backgroundColor: colorWhite,
                items: [
                  BottomNavigationBarItem(
                    icon: index == 0
                      ? SvgPicture.asset('assets/icon/home_green.svg')
                      : SvgPicture.asset(listIcons[0], width: 24, height: 24),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: index == 1
                      ? SvgPicture.asset('assets/icon/search_green.svg')
                      : SvgPicture.asset(listIcons[1], width: 24, height: 24),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: index == 2
                      ? SvgPicture.asset('assets/icon/my_green.svg')
                      : SvgPicture.asset(listIcons[2], width: 24, height: 24),
                    label: '마이페이지',
                  ),
                ],
              );
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Gaps.v14,
              Stack(
                children: [
                  Center(child: Image.asset('assets/image/main_groach.png', width: 64, height: 28)),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/icon/bell_off.png', width: 24, height: 24),
                        Gaps.h16,
                        Image.asset('assets/icon/search.png', width: 24, height: 24),
                        Gaps.h16,
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ValueListenableBuilder(
                    valueListenable: vnIndexTab,
                    builder: (context, index, child) {
                      if(index == 0) {
                        return TabHome();
                      } else if (index == 1) {
                        return TabSearch();
                      } else {
                        return TabMy();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
