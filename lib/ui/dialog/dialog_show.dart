import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/dialog/dialog_cancel_confirm.dart';
import 'package:practice1/ui/dialog/dialog_confirm.dart';


/// 확인 (pop)
/// 취소 / 확인 (무언가 지울 때 최종확인느낌)

/// 한줄짜리
class DialogShow1 extends StatelessWidget {
  final String text;
  const DialogShow1({
    required this.text,
    super.key});

  static Future<void> showDialogLine1(BuildContext context, String text) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogShow1(text: text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 146,
        width: 270,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Gaps.v42,
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Gaps.v26,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialogCancelConfirm(),
                Gaps.h10,
                DialogConfirm(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// 두줄짜리
class DialogShow2 extends StatelessWidget {
  final String text;
  const DialogShow2({
    required this.text,
    super.key});

  static Future<void> showDialogLine2(BuildContext context, String text) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogShow2(text: text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 146,
        width: 270,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v30,
            Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Gaps.v16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogCancelConfirm(),
                Gaps.h10,
                DialogConfirm(),
              ],
            )
          ],
        ),
      ),
    );
  }
}



