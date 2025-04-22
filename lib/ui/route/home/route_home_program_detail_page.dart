import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_review.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/card_program_scroll.dart';
import 'package:practice1/ui/component/card_review_scroll.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practice1/ui/route/home/route_home_programs.dart';
import 'package:practice1/ui/route/home/route_reservaion.dart';
import 'package:practice1/ui/route/review/route_review_view.dart';
import 'package:practice1/ui/route/route_picture.dart';
import 'package:practice1/ui/tab/tab_home.dart';
import 'package:practice1/utils/utils.dart';
import 'package:practice1/utils/utils_enum.dart';

class RouteHomeProgramDetailPage extends StatefulWidget {
  final ModelProgram modelProgram;

  final int index;

  const RouteHomeProgramDetailPage({
    required this.modelProgram,
    this.index = 0,
    super.key,
  });

  @override
  State<RouteHomeProgramDetailPage> createState() => _RouteHomeProgramDetailPageState();
}

class _RouteHomeProgramDetailPageState extends State<RouteHomeProgramDetailPage> {
  static final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        /// 위도, 경도
        // 37.2864,
        // 127.0110,
        widget.modelProgram.modelAddress.addressGeoPoint.latitude,
        widget.modelProgram.modelAddress.addressGeoPoint.longitude,
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialPosition = CameraPosition(
      target: LatLng(
        /// 위도, 경도
        // 37.2864,
        // 127.0110,
        widget.modelProgram.modelAddress.addressGeoPoint.latitude,
        widget.modelProgram.modelAddress.addressGeoPoint.longitude,
      ),
      zoom: 15,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.modelProgram.name} 프로그램'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 275,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RoutePicture(modelProgram: widget.modelProgram, pictureNumber: 0),
                          ),
                        );
                      },
                      child: ClipRRect(
                        child: Image.asset(
                          widget.modelProgram.listImgUrl.first,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  SizedBox(
                    height: 62,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          widget.modelProgram.listImgUrl.length,
                          (index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            RoutePicture(modelProgram: widget.modelProgram, pictureNumber: index),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.asset(
                                      widget.modelProgram.listImgUrl[index],
                                      //imagePath,
                                      width: 86,
                                      height: 62,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    if (index == widget.modelProgram.listImgUrl.length - 1) {
                                      return const SizedBox.shrink();
                                    } else {
                                      return Gaps.h10;
                                    }
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Gaps.v16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.modelProgram.name, style: TS.s16w500(colorGray600)),
                        Gaps.v8,
                        Text(
                          widget.modelProgram.desc,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TS.s18w400(colorBlack),
                        ),
                        Gaps.v10,
                        Row(
                          children: [
                            Image.asset('assets/icon/yellow_star.png', width: 16, height: 16),
                            Row(
                              children: [
                                Text(widget.modelProgram.averageStarRating.toString(), style: TS.s14w500(colorGray800)),
                                Gaps.h2,
                                Text('(${widget.modelProgram.countTotalReview.toString()})',
                                    style: TS.s14w500(colorGray800)),
                              ],
                            ),
                            Gaps.h4,
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => RouteReviewView(
                                      modelProgram: widget.modelProgram,
                                      listModelReview: listSampleModelReview,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Text('리뷰 보기', style: TS.s14w600(colorGreen600)),
                                    Gaps.h2,
                                    SvgPicture.asset('assets/icon/right_arrow.svg',
                                        colorFilter: ColorFilter.mode(colorGreen600, BlendMode.srcIn)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.v10,
                        Row(
                          children: [
                            Text('${widget.modelProgram.discountPercentage}%', style: TS.s16w700(Color(0XFFFA7014))),
                            Gaps.h2,
                            Text(
                              '${NumberFormat('#,###').format(widget.modelProgram.price)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: colorGray500,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: colorGray500,
                              ),
                            ),
                          ],
                        ),
                        Gaps.v4,
                        Text(
                          '${NumberFormat('#,###').format(widget.modelProgram.price - widget.modelProgram.price * widget.modelProgram.discountPercentage / 100)}원',
                          style: TS.s16w700(colorBlack),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v30,
                  CustomDivider(color: colorGray200, height: 1),
                  Gaps.v20,

                  /// 위치, 영업시간
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icon/local_gray.svg'),
                            Gaps.h6,
                            Text(widget.modelProgram.locationShortCut, style: TS.s14w500(colorGray800)),
                          ],
                        ),
                        Gaps.v10,
                        Row(
                          children: [
                            SvgPicture.asset('assets/icon/clock_gray.svg'),
                            Gaps.h6,
                            Text('영업중', style: TS.s14w600(Color(0xFF0059FF))),
                            Gaps.h6,
                            Text(
                              '${widget.modelProgram.timeProgramEnd.toDate().hour}:${widget.modelProgram.timeProgramEnd.toDate().minute}에 라스트오더',
                              style: TS.s14w500(colorGray800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.v20,

                  /// 제공 서비스
                  // todo: 간격조정 물어보기
                  CustomDivider(color: colorGray200, height: 1),
                  Gaps.v30,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('제공 서비스', style: TS.s18w700(colorBlack)),
                      ),
                      Gaps.v16,
                      Align(
                        //todo: 이거 다시 물어보기
                        alignment: Alignment.centerLeft,
                        child: MasonryGridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisCount: 4,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 16,
                          padding: EdgeInsets.zero,
                          itemCount: widget.modelProgram.listServiceType.length,
                          itemBuilder: (context, index) {
                            return ServiceCircle(serviceType: widget.modelProgram.listServiceType[index]);
                          },
                        ),
                      ),
                    ],
                  ),

                  /// 예약 안내
                  Gaps.v30,
                  CustomDivider(color: colorGray200, height: 10),
                  Gaps.v30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('예약 안내', style: TS.s18w700(colorBlack)),
                        Gaps.v16,
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('예약 가능', style: TS.s14w500(colorGray600)),
                                Gaps.h16,
                                Text('2025.01.30까지', style: TS.s14w500(colorBlack)),
                              ],
                            ),
                            Gaps.v8,
                            Row(
                              children: [
                                Text('최대 예약', style: TS.s14w500(colorGray600)),
                                Gaps.h16,
                                Text('최대 6인', style: TS.s14w500(colorBlack)),
                              ],
                            ),
                            Gaps.v8,
                            Row(
                              children: [
                                Text('오픈 주기', style: TS.s14w500(colorGray600)),
                                Gaps.h16,
                                Text('매월 1일 0시 오픈', style: TS.s14w500(colorBlack)),
                              ],
                            ),
                            Gaps.v8,
                            Row(
                              children: [
                                Text('다음 예약', style: TS.s14w500(colorGray600)),
                                Gaps.h16,
                                Text('2024.12.01 0시 오픈', style: TS.s14w500(colorBlack)),
                              ],
                            ),
                            Gaps.v30,
                            CustomDivider(color: colorGray200, height: 1),
                            Gaps.v30,
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// 빠른 예약
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('빠른 예약', style: TS.s18w700(colorBlack)),
                        Gaps.v16,
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('달력 부분 생략', style: TS.s18w700(colorRed)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  /// 지도 및 위치
                  Gaps.v30,
                  CustomDivider(color: colorGray200, height: 10),
                  Gaps.v30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('지도 및 위치', style: TS.s18w700(colorBlack)),
                          ],
                        ),
                        Container(
                          height: 160,
                          child: GoogleMap(
                            onMapCreated: (controller) {
                              _controller.complete(controller);
                            },
                            initialCameraPosition: initialPosition,
                            markers: {
                              Marker(
                                markerId: MarkerId('123'),
                                position: LatLng(
                                  /// 위도, 경도
                                  widget.modelProgram.modelAddress.addressGeoPoint.latitude,
                                  widget.modelProgram.modelAddress.addressGeoPoint.longitude,
                                ),
                              ),
                            },
                          ),
                        ),
                        Gaps.v16,
                        Text(widget.modelProgram.modelAddress.addressDetail, style: TS.s14w500(colorBlack)),
                      ],
                    ),
                  ),

                  /// 리뷰 메세지들
                  Gaps.v30,
                  CustomDivider(color: colorGray200, height: 10),
                  Gaps.v30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
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
                  ),

                  /// 사용자 리뷰들
                  Gaps.v8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
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
                  ),
                  Gaps.v30,
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('사용자 리뷰', style: TS.s18w700(colorBlack)),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RouteReviewView(
                                          modelProgram: widget.modelProgram, listModelReview: listSampleModelReview),
                                    ),
                                  );
                                },
                                child: MoreView()),
                          ],
                        ),
                        Gaps.v16,
                        Builder(builder: (context) {
                          // todo : 물어보기
                          final List<ModelReview> listModelReviewFilter = listSampleModelReview
                              .where((review) => review.uidOfModelProgram == widget.modelProgram.uid)
                              .toList();

                          print('프로그램 uid: ${widget.modelProgram.uid}');

                          print('리뷰 갯수: ${listModelReviewFilter.length}개');

                          return SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  listModelReviewFilter.length,
                                  (index) => Row(
                                    children: [
                                      CardReviewScroll(
                                        modelReview: listModelReviewFilter[index],

                                        /// 프로그램 정보 표시 안함
                                        isTabHome: false,
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (index == listModelReviewFilter.length - 1) {
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
                        }),
                      ],
                    ),
                  ),
                  Gaps.v30,
                  CustomDivider(color: colorGray200, height: 10),
                  Gaps.v30,
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text('비슷한 프로그램', style: TS.s18w700(colorBlack)),
                        Gaps.h4,
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RouteHomePrograms(programType: ProgramType.farm),
                              ),
                            );
                          },
                          child: MoreView(),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v6,
                  //todo: 정렬 물어보기
                  SizedBox(
                    height: 257,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          /// listTag 비교하여 일치한는 값들로 표시
                          listSampleModelProgram
                              .where(
                                  (program) => program.listTag.any((tag) => widget.modelProgram.listTag.contains(tag)))
                              .length,
                          (index) => Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CardProgramScroll(
                                    modelProgram: listSampleModelProgram
                                        .where((program) =>
                                            program.listTag.any((tag) => widget.modelProgram.listTag.contains(tag)))
                                        .toList()[index],
                                    width: 115,
                                    height: 115,
                                  ),
                                  Gaps.v8,
                                  Container(
                                    width: 115,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(width: 1, color: colorGreen600),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => RouteReservaion(),
                                          ),
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                          '예약하기',
                                          style: TS.s14w600(colorGreen600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Builder(
                                builder: (context) {
                                  if (index ==
                                      listSampleModelProgram
                                              .where((program) => program.listTag
                                                  .any((tag) => widget.modelProgram.listTag.contains(tag)))
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
                  ),
                  Gaps.v30,
                  Gaps.v10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ButtonAnimate(title: '예약하기', colorBg: colorGreen600),
                  ),
                  Gaps.v16,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceCircle extends StatelessWidget {
  final ServiceType serviceType;

  const ServiceCircle({
    required this.serviceType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorGray50,
            borderRadius: BorderRadius.circular(100),
          ),
          width: 50,
          height: 50,
          child: Center(
            child: Image.asset(
              UtilsEnum.getImgUrlFromServiceType(serviceType),
              width: 24,
              height: 24,
            ),
          ),
        ),
        Gaps.v8,
        Text(
          UtilsEnum.getNameFromServiceType(serviceType),
          style: TS.s13w500(colorBlack),
        ),
      ],
    );
  }
}

class ReviewBox extends StatelessWidget {
  final String iconPath;
  final String text;
  final int number;
  final Color boxColor;
  final Color boxBorderColor;
  final double boxBorderWidth;
  final TextStyle textStyle;

  const ReviewBox({
    required this.iconPath,
    required this.text,
    this.boxColor = colorGray50,
    this.boxBorderColor = Colors.transparent,
    this.boxBorderWidth = 0.0,
    this.textStyle = const TS.s14w500(colorBlack),
    this.number = 4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: boxColor,
        border: Border.all(color: boxBorderColor, width: boxBorderWidth),
      ),
      child: Column(
        children: [
          Gaps.v8,
          Row(
            children: [
              Gaps.h16,
              Center(child: SvgPicture.asset(iconPath, width: 20, height: 20)),
              Gaps.h6,
              Text(text, style: textStyle),
              Spacer(),
              Text('$number', style: TS.s14w400(colorGray600)),
              Gaps.h16,
            ],
          ),
        ],
      ),
    );
  }
}
