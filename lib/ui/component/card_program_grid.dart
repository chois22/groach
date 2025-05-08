// 작은 사진 화면 flutter_staggered_grid_view: ^0.7.0
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/route/home/route_home_program_detail_page.dart';

class CardProgramGrid extends StatelessWidget {
  final ModelProgram modelProgram;

  const CardProgramGrid({
    required this.modelProgram,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> vnHeartTouch = ValueNotifier<bool>(false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RouteHomeProgramDetailPage(modelProgram: modelProgram),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // 비율 설정
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  margin: EdgeInsets.only(right: 0),
                  // 각 컨테이너 간 간격
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 색상 변형
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: modelProgram.listImgUrl.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: colorWhiteShadow60, // colorWhiteShadow60 대체
                    borderRadius: BorderRadius.circular(95),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: vnHeartTouch,
                    builder: (context, touch, child) {
                      return GestureDetector(
                        onTap: () {
                          vnHeartTouch.value = !vnHeartTouch.value;
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            touch
                                ? 'assets/icon/heart_red.svg' // 터치 시 빨간 하트
                                : 'assets/icon/heart_outline.svg', // 기본 상태
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Gaps.v8,
          Text(
            modelProgram.name,
            style: TS.s13w500(colorGray600),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            modelProgram.desc,
            style: TS.s13w500(colorGray600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Gaps.v5,
          Row(
            children: [
              Image.asset('assets/icon/yellow_star.png', width: 16, height: 16),
              Text(modelProgram.averageStarRating.toStringAsFixed(1), style: TS.s13w500(colorGray800)),
              Gaps.h5,
              Expanded(
                child: Text(
                  modelProgram.modelAddress.addressBasic,
                  style: TS.s13w500(colorGray500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Gaps.v5,
          Row(
            children: [
              Text('${modelProgram.discountPercentage}%', style: TS.s16w700(Color(0XFFFA7014))),
              Gaps.h2,
              Text(
                NumberFormat('#,###').format(
                  modelProgram.price * (100 - modelProgram.discountPercentage) / 100,
                ),
                style: TS.s16w700(colorBlack),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
