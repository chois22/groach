import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/card_program_banner.dart';
import 'package:practice1/ui/component/card_program_grid.dart';
import 'package:practice1/ui/component/custom_divider.dart';

//todo: kjw : bottom navigation bar 만들기(complete)
// pop안되도록 설정하기

class RouteMain extends StatelessWidget {
  const RouteMain({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                // 상단 고정
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: 56, // 고정된 영역의 높이
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
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
                ),
              ),
              // 스크롤 가능한 부분
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CardProgramBanner(),
                    Gaps.v30,
                    IconCardGridView(),
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text('추천 프로그램', style: TS.s18w700(colorBlack)),
                          Gaps.h4,
                          Image.asset('assets/icon/sparkles.png', width: 15, height: 15),
                          Spacer(),
                          Text('더보기', style: TS.s14w500(colorGray600)),
                          SvgPicture.asset('assets/icon/right_arrow.svg', colorFilter: ColorFilter.mode(colorGray600, BlendMode.srcIn)),
                        ],
                      ),
                    ),
                    Gaps.v16,
                    Column(
                      children: [
                        HorizontalScroll(),
                      ],
                    ),
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 아이콘 8개 들어가는 컨테이너
class CardIcon extends StatelessWidget {
  final String iconPath;
  final String text;

  const CardIcon({required this.iconPath, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: colorGray50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gaps.v10,
        Text(text, style: TS.s14w600(colorBlack)),
      ],
    );
  }
}

// 아이콘 8개 생성 그리드뷰
class IconCardGridView extends StatelessWidget {
  const IconCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    // 텍스트 목록
    List<String> texts = ["체험", "숙박체험", "테마체험", "일일체험", "이벤트", "치유농업", "건강TEST", "귀촌귀농정보"];

    // 아이콘 경로 목록
    List<String> iconPaths = List.generate(8, (index) => "assets/icon/card_${index + 1}.png");

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: GridView.builder(
        shrinkWrap: true,
        // GridView의 크기를 자식에 맞게 줄임
        physics: NeverScrollableScrollPhysics(),
        // GridView 자체 스크롤 비활성화
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 가로 4개씩
          crossAxisSpacing: 10, // 가로 간격
          mainAxisSpacing: 21, // 세로 간격
        ),
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return CardIcon(
            iconPath: iconPaths[index], // 아이콘 경로
            text: texts[index], // 텍스트
          );
        },
      ),
    );
  }
}
