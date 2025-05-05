import 'package:flutter/material.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';
import 'package:practice1/ui/route/route_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/value/key.dart';
import '../../static/global.dart';

class RouteSplash extends StatefulWidget {
  const RouteSplash({super.key});

  @override
  State<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends State<RouteSplash> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Global.contextSplash = context;
  }

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  /// 회원가입을 하면 해당 유저의 uid를 메모리에 저장(spf)
  /// 메모리에서 uid를 가져온 뒤, 해당 문서를 조회하고 Global.userNotifier.value 에 ModelUser 넣기

  void _checkUser() async {
    /// 1. spf에서 uid 조회하기
    final SharedPreferences spf = await SharedPreferences.getInstance();

    final String? uid = spf.getString(keyUid);

    /// 만약에 uid가 저장되어 있지 않다 -> 로그인 페이지로
    if (uid == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => RouteAuthLogin()
        ),
      );
    }

    /// uid저장 되어 있다 -> 파베 문서 조회 후 메인으로 이동
    else {
      await Future.delayed(Duration(milliseconds: 1500));

      ///파베 문서 조회하고 메인 넘기기 !


      Navigator.of(context).push(
        MaterialPageRoute(
        builder: (_) => RouteMain()
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFFFD5),
      body: Center(
        child: Container(
          height: 201,
          width: 228,
          child: Image.asset('assets/image/main logo.png'),
        ),
      ),
    );
  }
}
