import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/route/home/route_home_program_detail_page.dart';

class CardReviewScroll extends StatelessWidget {
  final ModelProgram modelProgram;


  const CardReviewScroll({
    required this.modelProgram,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 209,
      child: AspectRatio(
        aspectRatio: 1 / 0.65,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      //  반지름 값이라 32/2 해줌
                      radius: 16,
                      backgroundImage: AssetImage('assets/image/avatar_image.png'),
                    ),
                    Gaps.h8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('홍길동', style: TS.s12w500(colorBlack)),
                        Gaps.v3,
                        Text('2024-10-19', style: TS.s12w500(colorGray500)),
                      ],
                    ),
                  ],
                ),
                Gaps.v10,
                Text(
                  '너무 만족스러운 프로그램이였어요! 할머님, 할아버님 모시고 갔는데 친절하셨고 난이도도 쉬워서 매우 만족스러운 체험이였습니다. 너무 만족스러운 프로그램이였어요! 다음에 또 참여하게 된다면 여기로 예약할 것같아요~~~~~~~~',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TS.s14w400(colorGray800),
                ),
                Gaps.v12,
                CustomDivider(color: colorGray200, height: 1),
                Gaps.v12,
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (_) => RouteHomeProgramDetailPage(
                        modelProgram: modelProgram,
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
                            modelProgram.listImgUrl.first,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gaps.h8,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(modelProgram.name, style: TS.s14w600(colorGray600)),
                            Gaps.v4,
                            Row(
                              children: [
                                Image.asset('assets/icon/yellow_star.png', width: 16, height: 16),
                                Text(modelProgram.averageStarRating.toString(), style: TS.s13w500(colorGray800)),
                                Gaps.h5,
                                Text(modelProgram.modelAddress.addressDetail, style: TS.s13w500(colorGray500)),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(top: 8, bottom: 8, left: 20),
                          child: SvgPicture.asset('assets/icon/right_arrow.svg', colorFilter: ColorFilter.mode(colorGray600, BlendMode.srcIn)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
