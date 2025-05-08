import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_review.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/key.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/static/global.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/dialog/dialog_cancel_confirm.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';
import 'package:practice1/ui/route/home/route_home_program_detail_page.dart';
import 'package:practice1/ui/route/review/route_review_picture.dart';
import 'package:practice1/ui/route/review/route_review_write.dart';
import 'package:practice1/utils/utils.dart';
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
  Map<String, int>? keyWordCounts;

  @override
  void initState() {
    super.initState();
    fetchKeywordCounts();
  }

  Future<void> fetchKeywordCounts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(keyReview).where(keyUidOfModelProgram, isEqualTo: widget.modelProgram).get();
    Utils.log.d(snapshot.docs.length);

    final Map<String, int> counts = {};

    for (var doc in snapshot.docs) {
      final keyWords = List<String>.from(doc[keyReviewKeyWord] ?? []);
      for (final keyWord in keyWords) {
        counts[keyWord] = (counts[keyWord] ?? 0) + 1;
      }
    }
    setState(() {
      keyWordCounts = counts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰 ${NumberFormat('#,###').format(widget.modelProgram.countTotalReview)}'),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () async {
              if (Global.userNotifier.value == (null)) {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => DialogCancelConfirm(text: '로그인이 필요합니다. \n로그인 페이지로 이동하시겠습니까?'),
                );
                if (result == true) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RouteAuthLogin(),
                    ),
                  );
                }
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RouteReviewWrite(modelProgram: widget.modelProgram),
                  ),
                );
              }
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

                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(keyReview)
                      .where(keyUidOfModelProgram, isEqualTo: widget.modelProgram.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                      return const SizedBox.shrink();
                    }
                    // 로딩중이면, 빈 사이즈 박스 반환
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }
                    final List<ModelReview> listModelReview =
                        snapshot.data!.docs.map((doc) => ModelReview.fromJson(doc.data() as Map<String, dynamic>)).toList();

                    Utils.log.f('프로그램 uid: ${widget.modelProgram.uid}');

                    Utils.log.f('리뷰 갯수: ${listModelReview.length}개');

                    int good_facility = 0;
                    int kind_owner = 0;
                    int luxury_facility = 0;
                    int good_view = 0;
                    int with_couple = 0;

                    for (ModelReview review in listModelReview) {
                      if (review.listReviewKeyWord.contains(ReviewKeyWord.good_facility)) {
                        good_facility++;
                      }

                      if (review.listReviewKeyWord.contains(ReviewKeyWord.kind_owner)) {
                        kind_owner++;
                      }
                      if (review.listReviewKeyWord.contains(ReviewKeyWord.luxury_facility)) {
                        luxury_facility++;
                      }
                      if (review.listReviewKeyWord.contains(ReviewKeyWord.good_view)) {
                        good_view++;
                      }
                      if (review.listReviewKeyWord.contains(ReviewKeyWord.with_couple)) {
                        with_couple++;
                      }
                    }

                    return Column(
                      children: [
                        ReviewBox(
                          iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.good_facility),
                          text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.good_facility),
                          number: good_facility,
                        ),
                        Gaps.v8,
                        ReviewBox(
                          iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.kind_owner),
                          text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.kind_owner),
                          number: kind_owner,
                        ),
                        Gaps.v8,
                        ReviewBox(
                          iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.luxury_facility),
                          text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.luxury_facility),
                          number: luxury_facility,
                        ),
                        Gaps.v8,
                        ReviewBox(
                          iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.good_view),
                          text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.good_view),
                          number: good_view,
                        ),
                        Gaps.v8,
                        ReviewBox(
                          iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.with_couple),
                          text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.with_couple),
                          number: with_couple,
                        ),
                        Gaps.v26,

                        Row(children: [Text('사용자 리뷰', style: TS.s18w700(colorBlack))]),
                        Gaps.v16,

                        /// 인기순, 평점순 정렬 부분
                        ValueListenableBuilder<int>(
                          valueListenable: vnSelectedFilter,
                          builder: (context, selectedFilter, child) {
                            return Row(
                              children: List.generate(2, (index) {
                                List<String> labels = ['최신순', '평점순'];
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
                        ValueListenableBuilder<int>(
                          valueListenable: vnSelectedFilter,
                          builder: (context, selectedFilter, child) {
                            List<ModelReview> sortedReviews = [...listModelReview];

                            if (selectedFilter == 0) {
                              // 작성 날짜 최신순
                              sortedReviews.sort((a, b) => b.modelUser.dateCreate.compareTo(a.modelUser.dateCreate));
                            } else {
                              // 평점 높은순
                              sortedReviews.sort((a, b) => b.starRating.compareTo(a.starRating));
                            }
                            return Column(
                                children: sortedReviews.map((reviewIndex) {
                                  int fullStars = reviewIndex.starRating.floor();

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundImage:
                                            reviewIndex.modelUser.userImg == null ? null : AssetImage(reviewIndex.modelUser.userImg!),
                                          ),
                                          Gaps.h8,
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              /// 리뷰 작성자 정보
                                              Text(reviewIndex.modelUser.nickname, style: TS.s13w500(colorBlack)),
                                              Row(
                                                children: List.generate(5, (index) {
                                                  if (index < fullStars) {
                                                    Utils.log.d('리뷰 ${reviewIndex.uid} 이미지 개수: ${reviewIndex.listImgUrl.length}');
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
                                            DateFormat('yyyy-MM-dd').format(reviewIndex.modelUser.dateCreate.toDate()),
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
                                                Utils.log.d('리뷰 ${reviewIndex.uid} 이미지 개수: ${reviewIndex.listImgUrl.length}');
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
                                                        child: CachedNetworkImage(
                                                          imageUrl: reviewIndex.listImgUrl[reviewImgIndex],
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
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
