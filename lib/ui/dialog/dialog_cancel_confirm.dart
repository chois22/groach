import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';

/// 확인 버튼
class DialogCancelConfirm extends StatelessWidget {
  final String text;
  const DialogCancelConfirm({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.v42,
            Text(text, style: TS.s16w500(colorBlack)),
            Gaps.v26,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      width: 110,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorGreen600,
                        width: 1,
                        ),
                        color: colorWhite,
                      ),
                      child: Center(child: Text('취소', style: TS.s18w600(colorGreen600))),
                    ),
                  ),
                ),
                Gaps.h10,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      width: 110,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorGreen600,
                      ),
                      child: Center(child: Text('확인', style: TS.s18w600(colorWhite))),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v20,
          ],
        ),
      ),
    );
  }
}
