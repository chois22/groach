import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';

/// 확인 버튼
class DialogConfirm extends StatelessWidget {
  final String text;

  const DialogConfirm({
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
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TS.s16w500(colorBlack).copyWith(height: 1.5),
              ),
            ),
            Gaps.v26,
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Container(
                width: 110,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Center(child: Text('확인', style: TS.s18w600(colorWhite))),
              ),
            ),
            Gaps.v20,
          ],
        ),
      ),
    );
  }
}
