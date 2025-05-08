import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice1/const/model/model_user.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';
import 'package:practice1/ui/route/route_main.dart';
import 'package:practice1/utils/utils.dart';
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

    /// 만약에 uid가 저장되어 있지 않다 -> 로그인 페이지로 (실제 앱에서는 메인을 볼 수 있어야됨 -> 메인)
    if (uid == null) {
      Utils.log.f('유저 조회 실패');
      Utils.log.f('SharedPreferences에서 읽은 uid: $uid');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // 유저 uid 가 없어도 메인으로 가지만, '리뷰 쓰기', '예약' 등을 누르면 로그인 페이지로 연동
            builder: (_) => RouteMain()
          //  builder: (_) => RouteAuthLogin()
        ),
      );
    }

    /// uid저장 되어 있다 -> 파베 문서 조회 후 메인으로 이동
    /// else (uid != null), (uid == userUid)
    else {
      await Future.delayed(Duration(milliseconds: 1500));

      ///파베 문서 조회하고 Global.userNotifier.value 에 조회한 유저를 넣기
      ///유저를 넣고 메인으로 보내기
      try {
        final doc = await FirebaseFirestore.instance.collection(keyUser).doc(uid).get();

        final modelUser = ModelUser.fromJson(doc.data()!);

        Utils.log.f('유저 조회 성공: 이름 : ${modelUser.name} 닉네임 : ${modelUser.nickname} UID : (${modelUser.uid})');

        Global.userNotifier.value = modelUser;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => RouteMain()
             // builder: (_) => RouteAuthLogin()
          ),
        );
      } catch (e, stack) {
        Utils.log.f('유저 조회 실패: $e\n$stack');
      }
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
