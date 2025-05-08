import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/custom_toast.dart';
import 'package:practice1/ui/route/route_splash.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  KakaoSdk.init(nativeAppKey: 'f1f3a1070b2eb4d91def774b9c3d86b5'); // 이 줄을 runApp 위에 추가한다.

  runApp(
    _Groach(),
  );
}


class _Groach extends StatelessWidget {
  const _Groach();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Pretendard',
          scaffoldBackgroundColor:colorWhite,

          appBarTheme: AppBarTheme(
            backgroundColor: colorWhite,
            foregroundColor: colorGray900,
            shadowColor: null,
            scrolledUnderElevation: 0,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TS.s18w600(colorBlack),
            iconTheme: IconThemeData(color: colorBlack),
          ),
        ),
        builder: (context, child) {
          Widget result = FToastHolder(child: child!);


          result = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: result,
          );

          return result;
        },
        home: RouteSplash(),
      ),
    );
  }
}


