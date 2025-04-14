import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/route/home/route_setting.dart';

class TabMy extends StatelessWidget {
  const TabMy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: kToolbarHeight,
          child: Stack(
            children: [
              Center(child: Image.asset('assets/image/main_groach.png', width: 64, height: 28)),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RouteSetting(),
                            ),
                          );
                        },
                        child: SvgPicture.asset('assets/icon/setting_icon.svg', width: 24, height: 24)),
                    Gaps.h20,
                  ],
                ),
              ),
            ],
          ),
        ),
        Gaps.v16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/image/user_image.png', width: 56, height: 56),
                  Gaps.h14,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('로그인', style: TS.s16w600(colorBlack)),
                          Gaps.h2,
                          SvgPicture.asset('assets/icon/right_arrow.svg', width: 16, height: 16, colorFilter: ColorFilter.mode(colorBlack, BlendMode.srcIn)),
                        ],
                      ),
                      Gaps.v4,
                      Text('로그인 후 더 많은 정보를 확인해보세요.', style: TS.s13w400(colorGray600)),
                    ],
                  ),
                ],
              ),
              Gaps.v20,
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorGray50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Gaps.v16,
                        Text('-', style: TS.s16w700(colorGreen600)),
                        Gaps.v5,
                        Text('진행중인 예약', style: TS.s14w500(colorGray800)),
                      ],
                    ),
                    Container(
                      height: 46,
                      width: 1,
                      color: colorWhite,
                    ),
                    Column(
                      children: [
                        Gaps.v16,
                        Text('-', style: TS.s16w700(colorGreen600)),
                        Gaps.v5,
                        Text('완료된 예약', style: TS.s14w500(colorGray800)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Gaps.v20,
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
        Gaps.v10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              MyInfoBox(iconPath: 'assets/icon/reservaion_icon.png', text: '예약내역'),
              MyInfoBox(iconPath: 'assets/icon/review_icon.png', text: '리뷰'),
              MyInfoBox(iconPath: 'assets/icon/good_heart_icon.png', text: '좋아요 한 프로그램'),
            ],
          ),
        ),
      ],
    );
  }
}

class MyInfoBox extends StatelessWidget {
  final String iconPath;
  final String text;
  
  const MyInfoBox({
    required this.iconPath,
    required this.text,
    super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Colors.transparent,
      child: Row(
        children: [
          Image.asset(iconPath, width: 20, height: 20),
          Gaps.h8,
          Text(text, style: TS.s16w500(colorBlack)),
          Spacer(),
          SvgPicture.asset('assets/icon/right_arrow.svg'),
        ],
      ),
    );
  }
}
