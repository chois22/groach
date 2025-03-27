import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/card_program_grid.dart';
import 'package:practice1/ui/component/card_program_scroll.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/route/recommendation_program.dart';
import 'package:practice1/ui/route/route_main.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  late ScrollController scrollController = ScrollController();
  late ValueNotifier<double> vnOpacity = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    vnOpacity = ValueNotifier<double>(0.0);

    scrollController.addListener(() {
      if (scrollController.offset > 50) {
        vnOpacity.value = 1.0;
      } else {
        vnOpacity.value = 0.0;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    vnOpacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            /// appbar
            Container(
              height: kToolbarHeight,
              child: Stack(
                children: [
                  Center(child: Image.asset('assets/image/main_groach.png', width: 64, height: 28)),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/icon/bell_off.png', width: 24, height: 24),
                        Gaps.h16,
                        GestureDetector(
                          onTap: (){
                            RouteMain.vnIndexTab.value = 1;
                          },
                            child: Image.asset('assets/icon/search.png', width: 24, height: 24)),
                        Gaps.h16,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    /// banner
                    AspectRatio(
                      aspectRatio: 375 / 170,
                      child: Swiper(
                        itemCount: listMainBanner.length,
                        autoplay: true,
                        autoplayDelay: 3000,
                        duration: 1000,
                        onTap: (index) {},
                        loop: true,
                        outer: false,
                        pagination: SwiperCustomPagination(
                          builder: (context, config) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Text('${config.activeIndex + 1} / ${config.itemCount}'),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      config.itemCount,
                                      (index) {
                                        bool isActive = index == config.activeIndex;
                                        return AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          margin: EdgeInsets.symmetric(horizontal: 4),
                                          width: isActive ? 16 : 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: isActive ? Colors.black : Colors.grey,
                                            borderRadius: BorderRadius.circular(8), // 타원형 효과
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Gaps.v10,
                                ],
                              ),
                            );
                          },
                        ),
                        itemBuilder: (context, index) {
                          return Image.asset(listMainBanner[index]);
                        },
                      ),
                    ),
                    Gaps.v30,
                    IconCardGridView(),
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v20,
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Text('추천 프로그램', style: TS.s18w700(colorBlack)),
                          Gaps.h4,
                          Image.asset('assets/icon/sparkles.png', width: 15, height: 15),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RecommendationProgram(),
                                ),
                              );
                            },
                            child: IntrinsicHeight(
                              child: Container(
                                color: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                child: Row(
                                  children: [
                                    Text('더보기', style: TS.s14w500(colorGray600)),
                                    SvgPicture.asset('assets/icon/right_arrow.svg',
                                        colorFilter: ColorFilter.mode(colorGray600, BlendMode.srcIn)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v6,
                    SizedBox(
                      height: 216,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            10,
                            (index) => Row(
                              children: [
                                CardProgramScroll(index: index),
                                Builder(
                                  builder: (context) {
                                    if (index == 9) {
                                      return const SizedBox.shrink();
                                    } else {
                                      return Gaps.h10;
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text('인기 프로그램', style: TS.s18w700(colorBlack)),
                          Gaps.h4,
                          SvgPicture.asset('assets/icon/hot_icon.svg', width: 47, height: 24),
                          Spacer(),
                          Text('더보기', style: TS.s14w500(colorGray600)),
                          SvgPicture.asset('assets/icon/right_arrow.svg', colorFilter: ColorFilter.mode(colorGray600, BlendMode.srcIn)),
                        ],
                      ),
                    ),
                    Gaps.v16,
                    MasonryGridView.count(
                      shrinkWrap: true,
                      primary: false,
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return CardProgramGrid(index: index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        /// 스크롤 하면 좌측 하단에 나타나는 화살표
        ValueListenableBuilder(
          valueListenable: vnOpacity,
          builder: (context, opacity, child) {
            return Positioned(
              bottom: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: (){
                    scrollController.animateTo(
                      0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorWhite,
                      border: Border.all(
                        color: colorGray400,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_upward, color: colorGray700),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
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
    double iconSize = MediaQuery.of(context).size.width * 0.1;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            // width: 60,
            // height: 60,
            decoration: BoxDecoration(
              color: colorGray50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                // width: 32,
                // height: 32,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Gaps.v10,
        Text(text, style: TS.s14w600(colorBlack)),
      ],
    );
  }
}

// todo : 그리드뷰 배운걸로 바꾸기.
// 아이콘 8개 생성 그리드뷰
class IconCardGridView extends StatelessWidget {
  const IconCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    // 텍스트 목록
    List<String> texts = ["체험", "숙박체험", "테마체험", "일일체험", "이벤트", "치유농업", "건강TEST", "귀촌귀농정보"];

    // 아이콘 경로 목록
    List<String> iconPaths = List.generate(8, (index) => "assets/icon/card_${index + 1}.png");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MasonryGridView.count(
          shrinkWrap: true,
          // 스크롤 금지
          primary: false,
          crossAxisCount: 4,
          crossAxisSpacing: 30,
          mainAxisSpacing: 21,
          padding: EdgeInsets.symmetric(horizontal: 22.5),
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return CardIcon(
              iconPath: iconPaths[index], // 아이콘 경로
              text: texts[index], // 텍스트
            );
          },
        ),
      ],
    );
  }
}
