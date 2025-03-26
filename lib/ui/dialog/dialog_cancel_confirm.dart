import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';

/// 취소 버튼
class DialogCancelConfirm extends StatelessWidget {
  const DialogCancelConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorWhite,
            border: Border.all(
              color: colorGreen600,
              width: 1,
            ),
          ),
          child: Center(child: Text('취소', style: TS.s18w600(colorGreen600))),
        ),
      ),
    );
  }
}