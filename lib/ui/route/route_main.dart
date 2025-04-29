import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/tab/tab_home.dart';
import 'package:practice1/ui/tab/tab_my.dart';
import 'package:practice1/ui/tab/tab_search.dart';

/// 어느정도 내려가면 위로 화살표
//todo: kjw : bottom navigation bar 만들기(complete)
// pop안되도록 설정하기

class RouteMain extends StatefulWidget {
  final Map<String, dynamic>? user;
  const RouteMain({
    this.user,
    super.key});

  static ValueNotifier<int> vnIndexTab = ValueNotifier(0);

  @override
  State<RouteMain> createState() => _RouteMainState();
}

class _RouteMainState extends State<RouteMain> {
  final ScrollController scrollController = ScrollController();
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
          height: kBottomNavigationBarHeight,
          decoration: BoxDecoration(
            color: colorWhite,
            border: Border(
              top: BorderSide(color: colorGray200, width: 1),
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: RouteMain.vnIndexTab,
            builder: (context, indexTab, child) {
              return Row(
                children: List.generate(
                  listTitleMainBottomNavi.length,
                  (index) => _BottomNaviItem(
                    imgUrl: indexTab == index ? listImgSelectedMainBottomNavi[index] : listImgOutlinedMainBottomNavi[index],
                    title: listTitleMainBottomNavi[index],
                    isSelected: indexTab == index,
                    onTap: (){ /// 홈버튼 누를 때 조건문 추가하기
                      RouteMain.vnIndexTab.value = index;
                    },
                  ),
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: RouteMain.vnIndexTab,
            builder: (context, index, child) {
              if (index == 0) {
                return TabHome(user: widget.user);
              } else if (index == 1) {
                return TabSearch();
              } else {
                return TabMy(user: widget.user);
              }
            },
          ),
        ),
      ),
    );
  }
}

class _BottomNaviItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final bool isSelected;
  final void Function() onTap;

  const _BottomNaviItem({
    required this.imgUrl,
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imgUrl,
                width: 24,
                height: 24,
                //colorFilter: ColorFilter.mode(isSelected ? colorGreen600 : colorGray50, BlendMode.srcIn),
              ),
              Gaps.v4,
              Text(
                title,
                style: TS.s10w700(
                  isSelected ? colorGreen600 : colorGray500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
