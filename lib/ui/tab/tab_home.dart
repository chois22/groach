import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_review.dart';
import 'package:practice1/const/model/model_user.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/key.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/card_program_grid.dart';
import 'package:practice1/ui/component/card_program_scroll.dart';
import 'package:practice1/ui/component/card_review_scroll.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/dialog/dialog_confirm.dart';
import 'package:practice1/ui/route/home/route_home_programs.dart';
import 'package:practice1/ui/route/route_main.dart';
import 'package:practice1/ui/route/route_splash.dart';
import 'package:practice1/utils/utils.dart';
import 'package:practice1/utils/utils_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TabHome extends StatefulWidget {
  final Map<String, dynamic>? user;

  const TabHome({required this.user, super.key});

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
                            onTap: () {
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

            /// 프로그램 불러오기 get()
            // ElevatedButton(
            //   onPressed: () async {
            //     final qs = await FirebaseFirestore.instance.collection('program').get();
            //     final List<ModelProgram> listModelProgram = [];
            //     Utils.log.i('가져온 문서 수: ${qs.docs.length}');
            //   },
            //   child: Text(
            //     '서버 데이터 불러오기',
            //   ),
            // ),
            /// 로그아웃
            ElevatedButton(
              onPressed: () async {

                SharedPreferences spf = await SharedPreferences.getInstance();

                await spf.remove(keyUid);

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => RouteSplash(),
                  ),
                  (route) => false,
                );
              },
              child: Text('로그아웃'),
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

                    /// 상단 8개 아이콘
                    Gaps.v30,
                    IconCardGridView(),

                    /// 추천 프로그램
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v20,
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Text(
                            UtilsEnum.getNameFromProgramType(ProgramType.recommend),
                            style: TS.s18w700(colorBlack),
                          ),
                          Gaps.h4,
                          Image.asset(
                            UtilsEnum.getImgUrlFromProgramIcon(ProgramType.recommend),
                            width: 15,
                            height: 15,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RouteHomePrograms(programType: ProgramType.recommend),
                                ),
                              );
                            },
                            child: MoreView(),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v6,

                    /// 추천프로그램
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(keyProgram) // = 'program'
                            .where(keyProgramType, isEqualTo: ProgramType.recommend.name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                            return const SizedBox.shrink();
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          final List<ModelProgram> listModelProgramRecommend =
                              snapshot.data!.docs.map((doc) => ModelProgram.fromJson(doc.data())).toList();

                          return SizedBox(
                            height: 231,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  listModelProgramRecommend.where((program) => program.programType == ProgramType.recommend).length,
                                  (index) => Row(
                                    children: [
                                      CardProgramScroll(
                                        modelProgram:
                                            listModelProgramRecommend.where((e) => e.programType == ProgramType.recommend).toList()[index],
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (index ==
                                              listModelProgramRecommend
                                                      .where((program) => program.programType == ProgramType.recommend)
                                                      .length -
                                                  1) {
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
                          );
                        }),

                    /// 인기 프로그램
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(UtilsEnum.getNameFromProgramType(ProgramType.popular), style: TS.s18w700(colorBlack)),
                          Gaps.h4,
                          SvgPicture.asset(UtilsEnum.getImgUrlFromProgramIcon(ProgramType.popular), width: 47, height: 24),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RouteHomePrograms(programType: ProgramType.popular),
                                ),
                              );
                            },
                            child: MoreView(),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v16,
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(keyProgram)
                            .where(keyProgramType, isEqualTo: ProgramType.popular.name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          // 에러면, 빈 사이즈 박스 반환
                          if (snapshot.hasError) {
                            Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                            return const SizedBox.shrink();
                          }
                          // 로딩중이면, 빈 사이즈 박스 반환
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          final List<ModelProgram> listModelProgramPopular =
                              snapshot.data!.docs.map((doc) => ModelProgram.fromJson(doc.data())).toList();

                          return MasonryGridView.count(
                            shrinkWrap: true,
                            primary: false,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemCount: listModelProgramPopular.where((program) => program.programType == ProgramType.popular).length,
                            itemBuilder: (context, index) {
                              return CardProgramGrid(
                                modelProgram: listModelProgramPopular.where((e) => e.programType == ProgramType.popular).toList()[index],
                              );
                            },
                          );
                        }),

                    /// 급상승 프로그램
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(UtilsEnum.getNameFromProgramType(ProgramType.hot), style: TS.s18w700(colorBlack)),
                          Gaps.h4,
                          SvgPicture.asset(UtilsEnum.getImgUrlFromProgramIcon(ProgramType.hot), width: 47, height: 24),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RouteHomePrograms(programType: ProgramType.hot),
                                ),
                              );
                            },
                            child: MoreView(),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v6,
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(keyProgram)
                            .where(keyProgramType, isEqualTo: ProgramType.hot.name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                            return const SizedBox.shrink();
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          final List<ModelProgram> listModelProgramHot =
                              snapshot.data!.docs.map((doc) => ModelProgram.fromJson(doc.data())).toList();

                          return SizedBox(
                            height: 231,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  listModelProgramHot.where((program) => program.programType == ProgramType.hot).length,
                                  (index) => Row(
                                    children: [
                                      CardProgramScroll(
                                        modelProgram: listModelProgramHot.where((e) => e.programType == ProgramType.hot).toList()[index],
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (index ==
                                              listModelProgramHot.where((program) => program.programType == ProgramType.hot).length - 1) {
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
                          );
                        }),

                    /// 신규 프로그램
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            UtilsEnum.getNameFromProgramType(ProgramType.brand_new),
                            style: TS.s18w700(colorBlack),
                          ),
                          Gaps.h4,
                          SvgPicture.asset(
                            UtilsEnum.getImgUrlFromProgramIcon(ProgramType.brand_new),
                            width: 47,
                            height: 24,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RouteHomePrograms(programType: ProgramType.brand_new),
                                ),
                              );
                            },
                            child: MoreView(),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v16,
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(keyProgram)
                            .where(keyProgramType, isEqualTo: ProgramType.brand_new.name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                            return const SizedBox.shrink();
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          final List<ModelProgram> listModelProgramBrandNew =
                              snapshot.data!.docs.map((doc) => ModelProgram.fromJson(doc.data())).toList();

                          return MasonryGridView.count(
                            shrinkWrap: true,
                            primary: false,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemCount: listModelProgramBrandNew.where((program) => program.programType == ProgramType.brand_new).length,
                            itemBuilder: (context, index) {
                              return CardProgramGrid(
                                modelProgram: listModelProgramBrandNew.where((e) => e.programType == ProgramType.brand_new).toList()[index],
                              );
                            },
                          );
                        }),

                    /// 호캉스 프로그램
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            UtilsEnum.getNameFromProgramType(ProgramType.staycation),
                            style: TS.s18w700(colorBlack),
                          ),
                          Gaps.h4,
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RouteHomePrograms(programType: ProgramType.staycation),
                                ),
                              );
                            },
                            child: MoreView(),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v6,
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(keyProgram)
                            .where(keyProgramType, isEqualTo: ProgramType.staycation.name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                            return const SizedBox.shrink();
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          final List<ModelProgram> listModelProgramHokangs =
                              snapshot.data!.docs.map((doc) => ModelProgram.fromJson(doc.data())).toList();

                          return SizedBox(
                            height: 231,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  listModelProgramHokangs.where((program) => program.programType == ProgramType.staycation).length,
                                  (index) => Row(
                                    children: [
                                      CardProgramScroll(
                                        modelProgram:
                                            listModelProgramHokangs.where((e) => e.programType == ProgramType.staycation).toList()[index],

                                        // modelProgram: listSampleModelProgram[index],
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (index ==
                                              listModelProgramHokangs
                                                      .where((program) => program.programType == ProgramType.staycation)
                                                      .length -
                                                  1) {
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
                          );
                        }),

                    /// 농총한달살기 프로그램
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            UtilsEnum.getNameFromProgramType(ProgramType.rural),
                            style: TS.s18w700(colorBlack),
                          ),
                          Gaps.h4,
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RouteHomePrograms(programType: ProgramType.rural),
                                ),
                              );
                            },
                            child: MoreView(),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v6,
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(keyProgram)
                            .where(keyProgramType, isEqualTo: ProgramType.rural.name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                            return const SizedBox.shrink();
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          final List<ModelProgram> listModelProgramFrams =
                              snapshot.data!.docs.map((doc) => ModelProgram.fromJson(doc.data())).toList();

                          return SizedBox(
                            height: 231,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  listModelProgramFrams.where((program) => program.programType == ProgramType.rural).length,
                                  (index) => Row(
                                    children: [
                                      CardProgramScroll(
                                        modelProgram:
                                            listModelProgramFrams.where((e) => e.programType == ProgramType.rural).toList()[index],
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (index ==
                                              listModelProgramFrams.where((program) => program.programType == ProgramType.rural).length -
                                                  1) {
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
                          );
                        }),

                    /// 사용자 후기
                    Gaps.v30,
                    CustomDivider(color: colorGray200, height: 10),
                    Gaps.v30,
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text('사용자 최신 후기', style: TS.s18w700(colorBlack)),
                        ),
                      ],
                    ),
                    Gaps.v16,
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection(keyReview).snapshots(),
                      builder: (context, snapshot) {
                        // 에러면, 빈 사이즈 박스 반환
                        if (snapshot.hasError) {
                          Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                          return const SizedBox.shrink();
                        }
                        // 로딩중이면, 빈 사이즈 박스 반환
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }

                        final List<ModelReview> listModelReview = snapshot.data!.docs
                            .map((doc) => ModelReview.fromJson(doc.data() as Map<String, dynamic>))
                            .toList();


                        return Container(
                          height: 216,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                listModelReview.length,
                                (index) => Row(
                                  children: [
                                    CardReviewScroll(
                                      /// 리뷰 남긴 사람 정보, 리뷰 내용
                                      modelReview: listModelReview[index],
                        
                                      ///  프로그램 정보 표시
                                      isTabHome: true,
                                    ),
                                    Builder(
                                      builder: (context) {
                                        if (index == listModelReview.length - 1) {
                                          return const SizedBox.shrink();
                                        } else {
                                          return Gaps.h10;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),

                    /// 하단 회사 정보
                    Gaps.v30,
                    SvgPicture.asset('assets/image/bottominfo.svg'),
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
                  onTap: () {
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
        Text(
          text,
          style: TS.s14w600(colorBlack),
        ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MasonryGridView.count(
          shrinkWrap: true,
          // 스크롤 금지
          primary: false,
          crossAxisCount: 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 21,
          padding: EdgeInsets.symmetric(horizontal: 20),
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

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Text('더보기', style: TS.s14w500(colorGray600)),
          SvgPicture.asset('assets/icon/right_arrow.svg', colorFilter: ColorFilter.mode(colorGray600, BlendMode.srcIn)),
        ],
      ),
    );
  }
}
