import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_review.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/route/home/route_home_program_detail_page.dart';
import 'package:practice1/ui/route/review/route_review_picture.dart';
import 'package:practice1/ui/route/review/route_review_write.dart';
import 'package:practice1/utils/utils_enum.dart';

class RouteReviewView extends StatefulWidget {
  final ModelProgram modelProgram;
  final List<ModelReview> listModelReview;

  const RouteReviewView({
    required this.modelProgram,
    required this.listModelReview,
    super.key,
  });

  @override
  State<RouteReviewView> createState() => _RouteReviewViewState();
}

class _RouteReviewViewState extends State<RouteReviewView> {
  final ValueNotifier<int> vnSelectedFilter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '리뷰 ${NumberFormat('#,###').format(widget.modelProgram.countTotalReview)}',
          style: TS.s18w600(colorBlack),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                builder: (_) => RouteReviewWrite(
                  modelProgram: widget.modelProgram,
                ),
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
              child: Text(
                '리뷰쓰기',
                style: TS.s16w700(colorGreen600),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 리뷰 키워드 맨 위
                Container(
                  width: double.infinity,
                  height: 34,
                  decoration: BoxDecoration(
                    color: colorGreen100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('최근 한 달 동안 ', style: TS.s14w700(colorGray600)),
                      Text('1,600명 ', style: TS.s14w700(colorGreen600)),
                      Text('방문 / ', style: TS.s14w700(colorGray600)),
                      Text('44명', style: TS.s14w700(colorGreen600)),
                      Text('이 예약했어요', style: TS.s14w700(colorGray600)),
                    ],
                  ),
                ),
                Gaps.v8,

                /// 리뷰 키워드
                Column(
                  children: [
                    ReviewBox(
                      iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.good_facility),
                      text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.good_facility),
                    ),
                    Gaps.v8,
                    ReviewBox(
                      iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.kind_owner),
                      text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.kind_owner),
                    ),
                    Gaps.v8,
                    ReviewBox(
                      iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.luxury_facility),
                      text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.luxury_facility),
                    ),
                    Gaps.v8,
                    ReviewBox(
                      iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.good_view),
                      text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.good_view),
                    ),
                    Gaps.v8,
                    ReviewBox(
                      iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.with_couple),
                      text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.with_couple),
                    ),
                  ],
                ),
                Gaps.v26,

                Text('사용자 리뷰', style: TS.s18w700(colorBlack)),
                Gaps.v16,

                /// 인기순, 평점순 정렬 부분
                ValueListenableBuilder<int>(
                  valueListenable: vnSelectedFilter,
                  builder: (context, selectedFilter, child) {
                    return Row(
                      children: List.generate(2, (index) {
                        List<String> labels = ['인기순', '평점순'];
                        bool isSelected = index == selectedFilter;

                        return Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                          child: GestureDetector(
                            onTap: () {
                              vnSelectedFilter.value = index;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: isSelected ? colorGreen600 : colorGray400,
                                ),
                              ),
                              width: 68,
                              height: 29,
                              child: Center(
                                child: FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                                    child: Text(
                                      labels[index],
                                      style: isSelected ? TS.s14w600(colorGreen600) : TS.s14w600(colorGray600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                Gaps.v16,

                /// 리뷰 작성자 정보 리스트
                ...widget.listModelReview.map((reviewIndex) {
                  int fullStars = reviewIndex.starRating.floor();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage(reviewIndex.userImg),
                          ),
                          Gaps.h8,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// 리뷰 작성자 정보
                              Text(reviewIndex.userName, style: TS.s13w500(colorBlack)),
                              Row(
                                children: List.generate(5, (index) {
                                  if (index < fullStars) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: Image.asset(
                                        'assets/icon/yellow_star.png',
                                        width: 16,
                                        height: 16,
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: SvgPicture.asset(
                                        'assets/icon/grey_star_icon.svg',
                                        width: 16,
                                        height: 16,
                                      ),
                                    );
                                  }
                                }),
                              ),
                            ],
                          ),
                          Spacer(),

                          /// 리뷰 작성 날짜
                          Text(
                            DateFormat('yyyy-MM-dd').format(widget.modelProgram.timeProgramEnd.toDate()),
                            style: TS.s12w500(colorGray500),
                          ),
                        ],
                      ),
                      Gaps.v14,
                      /// 리뷰 이미지 첨부 부분
                      SizedBox(
                        height: 60,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              reviewIndex.listImgUrl.length,
                              (reviewImgIndex) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => RouteReviewPicture(
                                             // modelProgram: widget.modelProgram,
                                              modelReview: reviewIndex,
                                              pictureNumber: reviewImgIndex,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          reviewIndex.listImgUrl[reviewImgIndex],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    if (reviewImgIndex != reviewIndex.listImgUrl.length - 1) Gaps.h10,
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Gaps.v12,

                      /// 리뷰 내용 부분
                      Text(
                        reviewIndex.reviewText,
                        style: TS.s14w400(colorBlack),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Gaps.v20,
                      CustomDivider(color: colorGray200, height: 1),
                      Gaps.v20,
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
