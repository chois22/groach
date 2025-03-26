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

class TabHome extends StatelessWidget {
  const TabHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Column(
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
                    Image.asset('assets/icon/search.png', width: 24, height: 24),
                    Gaps.h16,
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
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
                width: 32,
                height: 32,
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


// // 아이콘 8개 생성 그리드뷰
// class IconCardGridView extends StatelessWidget {
//   const IconCardGridView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // 텍스트 목록
//     List<String> texts = ["체험", "숙박체험", "테마체험", "일일체험", "이벤트", "치유농업", "건강TEST", "귀촌귀농정보"];
//
//     // 아이콘 경로 목록
//     List<String> iconPaths = List.generate(8, (index) => "assets/icon/card_${index + 1}.png");
//
//     return Container(
//       padding: const EdgeInsets.only(left: 10.0, right: 10),
//       /// 오늘 배운걸로 바꿔보기
//       /// 1:1비율로
//       child: GridView.builder(
//         // true면 모든거 한번에 로드해서 보여준다.
//         shrinkWrap: true,
//         // GridView의 크기를 자식에 맞게 줄임
//         physics: NeverScrollableScrollPhysics(),
//         // GridView 자체 스크롤 비활성화
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4, // 가로 4개씩
//           crossAxisSpacing: 10, // 가로 간격
//           mainAxisSpacing: 21, // 세로 간격
//         ),
//         itemCount: texts.length,
//         itemBuilder: (context, index) {
//           return CardIcon(
//             iconPath: iconPaths[index], // 아이콘 경로
//             text: texts[index], // 텍스트
//           );
//         },
//       ),
//     );
//   }
// }