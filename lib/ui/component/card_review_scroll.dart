import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_review.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/route/home/route_home_program_detail_page.dart';

class CardReviewScroll extends StatefulWidget {
  final ModelReview modelReview;
  final bool isTabHome;

  const CardReviewScroll({
    required this.modelReview,
    this.isTabHome = true,
    super.key,
  });

  @override
  State<CardReviewScroll> createState() => _CardReviewScrollState();
}

class _CardReviewScrollState extends State<CardReviewScroll> {
  final ValueNotifier<int> vnSelectedFilter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    /// 탭 홈에서 사용자 리뷰 전체
    if (widget.isTabHome) {
      return SizedBox(
        width: 313,
        child: Container(
          margin: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorGray300,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //widget.modelReview.modelUser.userImg==null?null:widget.modelReview.modelUser.userImg!
                Row(
                  children: [
                    CircleAvatar(
                      //  반지름 값이라 32/2 해줌
                      radius: 16,
                      backgroundImage: widget.modelReview.modelUser.userImg == null
                          ? null
                          : AssetImage(widget.modelReview.modelUser.userImg!),
                    ),
                    Gaps.h8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.modelReview.modelUser.nickname, style: TS.s12w500(colorBlack)),
                        Gaps.v3,
                        Text(DateFormat('yyyy-MM-dd').format(widget.modelReview.dateCreate.toDate()),
                            style: TS.s12w500(colorGray500)),
                      ],
                    ),
                  ],
                ),
                Gaps.v10,

                /// 리뷰 텍스트(내용)
                Text(
                  widget.modelReview.reviewText,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TS.s14w400(colorGray800),
                ),
                Column(
                  children: [
                    Gaps.v12,
                    CustomDivider(color: colorGray200, height: 1),
                    Gaps.v12,
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RouteHomeProgramDetailPage(
                              modelProgram: widget.modelReview.modelProgram,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                widget.modelReview.modelProgram.listImgUrl.first,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gaps.h8,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.modelReview.modelProgram.name, style: TS.s14w600(colorGray600)),
                                Gaps.v4,
                                Row(
                                  children: [
                                    Image.asset('assets/icon/yellow_star.png', width: 16, height: 16),
                                    Text(widget.modelReview.modelProgram.averageStarRating.toString(),
                                        style: TS.s13w500(colorGray800)),
                                    Gaps.h5,
                                    Text(widget.modelReview.modelProgram.modelAddress.addressDetail,
                                        style: TS.s13w500(colorGray500)),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(top: 8, left: 20),
                              child: SvgPicture.asset('assets/icon/right_arrow.svg',
                                  colorFilter: ColorFilter.mode(colorGray600, BlendMode.srcIn)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      /// 디테일 페이지에서 사용자 리뷰
    } else {
      return SizedBox(
        width: 313,
        child: Container(
          margin: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorGray300,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      //  반지름 값이라 32/2 해줌
                      radius: 16,
                      backgroundImage: widget.modelReview.modelUser.userImg == null
                          ? null
                          : AssetImage(widget.modelReview.modelUser.userImg!),
                    ),
                    Gaps.h8,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(widget.modelReview.modelUser.nickname, style: TS.s12w500(colorBlack)),
                              Spacer(),
                              Text(DateFormat('yyyy-MM-dd').format(widget.modelReview.dateCreate.toDate()),
                                  style: TS.s12w500(colorGray500)),
                            ],
                          ),
                          Gaps.v6,

                          /// 별점 표시
                          Row(
                            children: List.generate(5, (index) {
                              int fullStars = widget.modelReview.starRating.floor();
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
                    ),
                  ],
                ),
                Gaps.v10,

                /// 리뷰 텍스트(내용)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.modelReview.reviewText,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TS.s14w400(colorGray800),
                      ),
                    ),
                    Gaps.h10,
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        widget.modelReview.listImgUrl.first,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
