import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/card_program_grid.dart';
import 'package:practice1/ui/component/card_program_scroll.dart';
import 'package:practice1/ui/component/card_review_scroll.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practice1/ui/route/home/route_home_programs.dart';
import 'package:practice1/ui/route/home/route_reservaion.dart';
import 'package:practice1/ui/route/route_picture.dart';
import 'package:practice1/ui/tab/tab_home.dart';

class RouteHomeProgramDetailPage extends StatelessWidget {
  final ModelProgram modelProgram;

  final int index;

  const RouteHomeProgramDetailPage({
    required this.modelProgram,
    this.index = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialPosition = CameraPosition(
      target: LatLng(
        /// 위도, 경도
        // 37.2864,
        // 127.0110,
        modelProgram.modelAddress.addressGeoPoint.latitude,
        modelProgram.modelAddress.addressGeoPoint.longitude,
      ),
      zoom: 15,
    );
    late final GoogleMapController controller;

    return Scaffold(
      appBar: AppBar(
        title: Text('${modelProgram.name} 프로그램'),
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
                            builder: (_) => RoutePicture(pictureNumber: 0),
                          ),
                        );
                      },
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/image/program_card_image1.png',
                          fit: BoxFit.cover,
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
                          10,
                          (index) {
                            String imagePath = 'assets/image/program_card_image${index % 4 + 1}.png';

                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => RoutePicture(pictureNumber: index % 4),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.asset(
                                      imagePath,
                                      width: 86,
                                      height: 62,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
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
                        Text(modelProgram.name, style: TS.s16w500(colorGray600)),
                        Gaps.v8,
                        Text(
                          modelProgram.desc,
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
                                Text(modelProgram.averageStarRating.toString(), style: TS.s14w500(colorGray800)),
                                Gaps.h2,
                                Text('(${modelProgram.countTotalReview.toString()})', style: TS.s14w500(colorGray800)),
                              ],
                            ),
                            Gaps.h4,
                            GestureDetector(
                              onTap: () {
                                print('리뷰 보기');
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
                            Text('${modelProgram.discountPercentage}%', style: TS.s16w700(Color(0XFFFA7014))),
                            Gaps.h2,
                            Text(
                              '${NumberFormat('#,###').format(modelProgram.price * modelProgram.discountPercentage / 100)}',
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
                          '${NumberFormat('#,###').format(modelProgram.price - modelProgram.price * modelProgram.discountPercentage / 100)}원',
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
                            Text(modelProgram.locationShortCut, style: TS.s14w500(colorGray800)),
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
                              '${modelProgram.timeProgramEnd.toDate().hour}:${modelProgram.timeProgramEnd.toDate().minute}에 라스트오더',
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
                  SizedBox(
                    height: modelProgram.listServiceType.length < 2 ? 112 : 210,
                   // height: modelProgram.listServiceType.length < 5 ? 112 : 210,
                    child: Column(
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
                           // itemCount: modelProgram.listServiceType.length ,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return ServiceCircle(serviceType: modelProgram.listServiceType[index % modelProgram.listServiceType.length]);
                            },
                          ),
                        ),
                      ],
                    ),
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
                            initialCameraPosition: initialPosition,
                            markers: {
                              Marker(
                                markerId: MarkerId('123'),
                                position: LatLng(
                                  /// 위도, 경도
                                  modelProgram.modelAddress.addressGeoPoint.latitude,
                                  modelProgram.modelAddress.addressGeoPoint.longitude,
                                ),
                              ),
                            },
                          ),
                        ),
                        Gaps.v16,
                        Text(modelProgram.modelAddress.addressDetail, style: TS.s14w500(colorBlack)),
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

                  /// 사용자 리뷰
                  Gaps.v8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        ReviewBox(iconPath: 'assets/icon/review_smile_icon.svg', text: '시설이 잘 관리되어 있어요'),
                        Gaps.v8,
                        ReviewBox(iconPath: 'assets/icon/review_thumb_icon.svg', text: '사장님이 친절해요'),
                        Gaps.v8,
                        ReviewBox(iconPath: 'assets/icon/review_diamond_icon.svg', text: '시설물이 력셔리해요'),
                        Gaps.v8,
                        ReviewBox(iconPath: 'assets/icon/review_mountain_icon.svg', text: '뷰가 좋아요'),
                        Gaps.v8,
                        ReviewBox(iconPath: 'assets/icon/review_heart_icon.svg', text: '연인과 함께 가기 좋아요'),
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
                            MoreView(),
                          ],
                        ),
                        Gaps.v16,
                        SizedBox(
                          height: 216,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                10,
                                (index) => Row(
                                  children: [
                                    CardReviewScroll(
                                      modelProgram: listSampleModelProgram[index % listSampleModelProgram.length],
                                    ),
                                    Builder(
                                      builder: (context) {
                                        if (index == 9) {
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
                        ),
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
                  SizedBox(
                    height: 257,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          10,
                          (index) => Row(
                            children: [
                              Column(
                                children: [
                                  CardProgramScroll(
                                    modelProgram: listSampleModelProgram[index % listSampleModelProgram.length],
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

                  //todo: 카드 각각에 예약하기는 아직 못넣었음.
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

Map<ServiceType, Map<String, String>> serviceMap = {
  ServiceType.wifi: {'icon': 'assets/icon/wifi_icon.png', 'text': '와이파이'},
  ServiceType.pet: {'icon': 'assets/icon/pet_icon.png', 'text': '반려동물'},
  ServiceType.parking: {'icon': 'assets/icon/parking_icon.png', 'text': '주차'},
};

class ServiceCircle extends StatelessWidget {
  final ServiceType serviceType;

  const ServiceCircle({
    required this.serviceType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final service = serviceMap[serviceType]!;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorGray50,
            borderRadius: BorderRadius.circular(100),
          ),
          width: 50,
          height: 50,
          child: Center(child: Image.asset(service['icon']!, width: 24, height: 24)),
        ),
        Gaps.v8,
        Text(service['text']!, style: TS.s13w500(colorBlack)),
      ],
    );
  }
}

class ReviewBox extends StatelessWidget {
  final String iconPath;
  final String text;

  const ReviewBox({
    required this.iconPath,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorGray50,
      ),
      child: Column(
        children: [
          Gaps.v8,
          Row(
            children: [
              Gaps.h16,
              Center(child: SvgPicture.asset(iconPath, width: 20, height: 20)),
              Gaps.h6,
              Text(text, style: TS.s14w500(colorBlack)),
              Spacer(),
              Text('+4', style: TS.s14w400(colorGray600)),
              Gaps.h16,
            ],
          ),
        ],
      ),
    );
  }
}
