import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/dialog/dialog_cancel_confirm.dart';
import 'package:practice1/ui/page/review/page_review_complete.dart';
import 'package:practice1/ui/route/home/route_home_program_detail_page.dart';
import 'package:practice1/utils/utils_enum.dart';

class RouteReviewWrite extends StatefulWidget {
  final ModelProgram modelProgram;

  const RouteReviewWrite({
    required this.modelProgram,
    super.key,
  });

  @override
  State<RouteReviewWrite> createState() => _RouteReviewWriteState();
}

class _RouteReviewWriteState extends State<RouteReviewWrite> {
  ValueNotifier<int> vnSelectedStar = ValueNotifier<int>(0);
  final ValueNotifier<List<ReviewKeyWord>> vnListReviewKeyWord = ValueNotifier([]);

  //todo: vnListSelectedReviewBoxes 지우고, vnListReviewKeyWord 로 구현하기
  List<ValueNotifier<bool>> vnListSelectedReviewBoxes = List.generate(5, (index) => ValueNotifier<bool>(false));
  final TextEditingController tecReviewWrite = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final PageController pageController = PageController();

  @override
  void dispose() {
    tecReviewWrite.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('리뷰 쓰기', style: TS.s18w600(colorBlack))),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gaps.v16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          widget.modelProgram.listImgUrl.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Gaps.h8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.modelProgram.name, style: TS.s15w500(colorGray600)),
                            Gaps.v5,
                            Text(
                              widget.modelProgram.desc,
                              style: TS.s16w400(
                                colorBlack,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.v26,
                CustomDivider(color: colorGray200, height: 10),
                Gaps.v26,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Text('별점을 눌러 만족도를 알려주세요.', style: TS.s18w600(colorGray900)),
                      Gaps.v16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return ValueListenableBuilder(
                            valueListenable: vnSelectedStar,
                            builder: (context, selectedStar, child) {
                              String assetName = index < selectedStar
                                  ? 'assets/icon/yellow_star_icon.svg'
                                  : 'assets/icon/grey_star_icon.svg';
                              return GestureDetector(
                                onTap: () {
                                  vnSelectedStar.value = index + 1;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: SvgPicture.asset(
                                    assetName,
                                    width: 28,
                                    height: 28,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                      ValueListenableBuilder(
                        valueListenable: vnSelectedStar,
                        builder: (context, selectedStar, child) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                            child: Text('$selectedStar.0', style: TS.s24w700(Color(0xFFFAAD14))),
                          );
                        },
                      ),
                      CustomDivider(color: colorGray200, height: 1),
                      Gaps.v20,

                      /// 리뷰 체크 부분
                      Column(
                        children: List.generate(5, (index) {
                          return ValueListenableBuilder(
                            valueListenable: vnListSelectedReviewBoxes[index],
                            builder: (context, listSelectedReviewBoxes, child) {
                              return GestureDetector(
                                onTap: () {
                                  vnListSelectedReviewBoxes[index].value = !listSelectedReviewBoxes;
                                },
                                child: Column(
                                  children: [
                                    ReviewBox(
                                      iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(ReviewKeyWord.values[index]),
                                      text: UtilsEnum.getNameFromReviewKeyWord(ReviewKeyWord.values[index]),
                                      textStyle:
                                          listSelectedReviewBoxes ? TS.s14w700(colorGreen600) : TS.s14w500(colorBlack),
                                      boxColor: listSelectedReviewBoxes ? colorGreen50 : colorWhite,
                                      boxBorderColor: listSelectedReviewBoxes ? colorGreen600 : colorGray200,
                                      boxBorderWidth: 1.0,
                                    ),
                                    Gaps.v8,
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),
                      Gaps.v12,
                      Row(
                        children: [
                          Text('리뷰 작성', style: TS.s14w500(colorGray700)),
                        ],
                      ),
                      Gaps.v8,
                      ValueListenableBuilder(
                        valueListenable: tecReviewWrite,
                        builder: (context, _, child) => SizedBox(
                          height: 250,
                          child: TextFieldDefault(
                            controller: tecReviewWrite,
                            focusNode: focusNode,
                            hintText: '리뷰를 작성해 주세요.',
                            colorBorder: focusNode.hasFocus ? colorGreen600 : colorGray200,
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: null,
                            expands: true,
                            maxLength: 20,
                          ),
                        ),
                      ),
                      Gaps.v20,
                      Row(
                        children: [
                          Text('사진 업로드', style: TS.s14w500(colorGray700)),
                          Text('(최대 5장)', style: TS.s14w500(colorGray500)),
                        ],
                      ),
                      Gaps.v8,
                      SizedBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              5,
                              (index) => Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: colorWhite,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: colorGray300, width: 1),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        print('사진 업로드');
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/icon/circle+.svg'),
                                          Gaps.v8,
                                          Text('사진 업로드', style: TS.s13w500(colorGray500)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (index == 4) {
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
                      Gaps.v16,
                      GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDialog(
                            context: context,
                            builder: (context) => DialogCancelConfirm(
                              text: '리뷰를 등록하시겠어요?',
                            ),
                          );
                        },
                        child: ButtonAnimate(title: '작성 완료', colorBg: colorGreen600),
                      ),
                      Gaps.v16,
                    ],
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

// FocusManager.instance.primaryFocus?.unfocus();
// PageReviewComplete(
// widget.pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
// ),
