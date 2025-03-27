import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';

/// 확인 버튼
class DialogConfirm extends StatelessWidget {
  const DialogConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('한 줄짜리 텍스트창 팝업입니다.'),
          ],
        ),
      ),
    );
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // 다이얼로그 닫기
        },
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          child: Center(child: Text('확인', style: TS.s18w600(colorWhite))),
        ),
      ),
    );
  }
}
