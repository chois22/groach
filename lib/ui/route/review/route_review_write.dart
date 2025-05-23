import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_review.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/key.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/static/global.dart';
import 'package:practice1/ui/component/button_animate.dart';
import 'package:practice1/ui/component/custom_divider.dart';
import 'package:practice1/ui/component/textfield_default.dart';
import 'package:practice1/ui/dialog/dialog_cancel_confirm.dart';
import 'package:practice1/ui/dialog/dialog_confirm.dart';
import 'package:practice1/ui/route/review/route_review_complete.dart';
import 'package:practice1/utils/utils_enum.dart';
import 'package:uuid/uuid.dart';

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
      onTap: () {
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
                        child: CachedNetworkImage(
                          imageUrl: widget.modelProgram.listImgUrl.first,
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
                              String assetName =
                                  index < selectedStar ? 'assets/icon/yellow_star_icon.svg' : 'assets/icon/grey_star_icon.svg';
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
                        children: List.generate(ReviewKeyWord.values.length, (index) {
                          final keyword = ReviewKeyWord.values[index];
                          return ValueListenableBuilder<List<ReviewKeyWord>>(
                            valueListenable: vnListReviewKeyWord,
                            builder: (context, selectedKeywords, child) {
                              final isSelected = selectedKeywords.contains(keyword);
                              return GestureDetector(
                                onTap: () {
                                  final currentList = List<ReviewKeyWord>.from(selectedKeywords);
                                  if (isSelected) {
                                    currentList.remove(keyword);
                                  } else {
                                    currentList.add(keyword);
                                  }
                                  vnListReviewKeyWord.value = currentList;
                                },
                                child: Column(
                                  children: [
                                    _ReviewBox(
                                      iconPath: UtilsEnum.getNameFromReviewKeyWordIcon(keyword),
                                      text: UtilsEnum.getNameFromReviewKeyWord(keyword),
                                      textStyle: isSelected ? TS.s14w700(colorGreen600) : TS.s14w500(colorBlack),
                                      boxColor: isSelected ? colorGreen50 : colorWhite,
                                      boxBorderColor: isSelected ? colorGreen600 : colorGray200,
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
                          height: 171,
                          child: TextFieldDefault(
                            controller: tecReviewWrite,
                            focusNode: focusNode,
                            hintText: '리뷰를 작성해 주세요. (최대 500자)',
                            colorBorder: focusNode.hasFocus ? colorGreen600 : colorGray200,
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: null,
                            expands: true,
                            maxLength: 500,
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
                        onTap: () async {
                          if (vnSelectedStar.value == 0) {
                            showDialog(
                              context: context,
                              builder: (context) => DialogConfirm(
                                text: '별점을 최소 1점 이상 선택해주세요.',
                              ),
                            );
                            return;
                          }

                          if (vnListReviewKeyWord.value.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => DialogConfirm(
                                text: '리뷰 키워드를 1개 이상 선택해주세요.',
                              ),
                            );
                            return;
                          }

                          if (tecReviewWrite.text.trim().isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => DialogConfirm(
                                text: '리뷰 내용을 입력해 주세요.',
                              ),
                            );
                            return;
                          }

                          ModelReview modelReview = ModelReview(
                            uid: Uuid().v1(),
                            dateCreate: Timestamp.now(),
                            uidOfModelProgram: widget.modelProgram.uid,
                            modelProgram: widget.modelProgram,
                            uidOfModelUser: Global.userNotifier.value                                                                                                                                     !.uid,
                            modelUser: Global.userNotifier.value!,
                            listReviewKeyWord: vnListReviewKeyWord.value,
                            reviewText: tecReviewWrite.text.trim(),
                            starRating: vnSelectedStar.value,
                            listImgUrl: [],
                          );

                          FirebaseFirestore.instance.collection(keyReview).doc(modelReview.uid).set(modelReview.toJson());

                          // 프로그램의 평균 별점과 리뷰 수를 업데이트
                          final programRef = FirebaseFirestore.instance.collection(keyProgram).doc(widget.modelProgram.uid);
                          // 기존 평균 별점과 리뷰 수 가져오기
                          final programDoc = await programRef.get();
                          if (programDoc.exists) {
                            final currentAvgRating = programDoc.data()?[keyAverageStarRating] as num? ?? 0; // 기본값 0.0으로 설정
                            final currentReviewCount = programDoc.data()?[keyCountTotalReview] as int? ?? 0; // 기본값 0으로 설정

                            // 새로운 평균 별점 계산
                            final newAvgRating = (currentAvgRating * currentReviewCount + vnSelectedStar.value) / (currentReviewCount + 1);

                            // Update: 프로그램 문서의 평균 별점과 리뷰 수만 업데이트
                            await programRef.update({
                              keyAverageStarRating: newAvgRating,
                              keyCountTotalReview: FieldValue.increment(1), // 리뷰 수 1 증가
                            });
                          } else {
                            // 문서가 없을 경우 적절한 처리
                            print('Program document does not exist');
                          }
                          // get : 가져오기
                          //FirebaseFirestore.instance.collection(keyReview)..where(keyUidOfModelUser,isEqualTo: Global.userNotifier.value!.uid).get();

                          FocusManager.instance.primaryFocus?.unfocus();
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => DialogCancelConfirm(
                              text: '리뷰를 등록하시겠어요?',
                            ),
                          );
                          if (result == true) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RouteReviewComplete(),
                              ),
                            );
                          }
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

class _ReviewBox extends StatelessWidget {
  final String iconPath;
  final String text;
  final int number;
  final Color boxColor;
  final Color boxBorderColor;
  final double boxBorderWidth;
  final TextStyle textStyle;

  const _ReviewBox({
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
            ],
          ),
        ],
      ),
    );
  }
}
