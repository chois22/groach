import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/data.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/key.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/card_program_grid.dart';
import 'package:practice1/utils/utils.dart';
import 'package:practice1/utils/utils_enum.dart';

class RouteHomePrograms extends StatefulWidget {
  final ProgramType programType;

  const RouteHomePrograms({
    required this.programType,
    super.key,
  });

  @override
  State<RouteHomePrograms> createState() => _RouteHomeProgramsState();
}

class _RouteHomeProgramsState extends State<RouteHomePrograms> {
  final ValueNotifier<int> vnSelectedFilter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final List<ModelProgram> listModelProgram = listSampleModelProgram.where((e) => e.programType == widget.programType).toList();

    return Scaffold(
      appBar: AppBar(
        /// 앱바 프로그램명 연동
        title: Text(UtilsEnum.getNameFromProgramType(widget.programType)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gaps.v16,
                  ValueListenableBuilder<int>(
                    valueListenable: vnSelectedFilter,
                    builder: (context, selectedFilter, child) {
                      return Row(
                        children: List.generate(3, (index) {
                          List<String> labels = ['인기순', '평점순', '가격순'];
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
                  Gaps.v20,
                  Expanded(
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<int>(
                        valueListenable: vnSelectedFilter,
                        builder: (context, selectedFilter, child) {
                          return Center(
                            child: Column(
                              children: [
                                /*      if (selectedFilter == 0) Text('인기순 화면.', style: TS.s16w600(colorBlack)),
                                if (selectedFilter == 1) Text('평점순 화면.', style: TS.s16w600(colorBlack)),
                                if (selectedFilter == 2) Text('가격순 화면.', style: TS.s16w600(colorBlack)),*/
                                Gaps.v20,
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection(keyProgram) // = 'program'
                                        .where(keyProgramType, isEqualTo: widget.programType.name)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        Utils.log.f('${snapshot.error}\n${snapshot.stackTrace}');
                                        return const SizedBox.shrink();
                                      }

                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const SizedBox.shrink();
                                      }

                                      final List<ModelProgram> listModelProgramFireBase =
                                          snapshot.data!.docs.map((doc) => ModelProgram.fromJson(doc.data())).toList();

                                      return MasonryGridView.count(
                                        shrinkWrap: true,
                                        primary: false,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 20,
                                        itemCount: listModelProgramFireBase.length,
                                        itemBuilder: (context, index) {
                                          return CardProgramGrid(
                                            modelProgram: listModelProgramFireBase[index],
                                          );
                                        },
                                      );
                                    }),
                                Gaps.v30,
                                SvgPicture.asset('assets/image/bottominfo.svg'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
