import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:practice1/const/static/global.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/custom_toast.dart';

class Utils{
  /// 로그 찍기
  static final log = Logger(printer: PrettyPrinter(methodCount: 1));

  /// 숫자 쉼표 포맷
  static final number = NumberFormat("#,###");


  /// 토스트 메세지
  static void toast({
    required BuildContext context,
    required String desc,

    int duration = 1000,
    // .top 내용 표시 위치
    ToastGravity toastGravity = ToastGravity.CENTER,
    double bottomMargin = kBottomNavigationBarHeight + 6,
  }) {
    FToast fToast = FToast();
    fToast.init(Global.contextSplash ?? context);

    Widget toast = Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: bottomMargin),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorGrayShadow70,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        desc,
        style: const TS.s16w500(colorWhite),
        textAlign: TextAlign.center,
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: toastGravity,
      isDismissable: true,
      toastDuration: Duration(milliseconds: duration),
    );
  }
}