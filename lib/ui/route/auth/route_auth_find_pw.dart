import 'package:flutter/material.dart';
// id랑 ui는 거의 비슷함

class RouteAuthFindPw extends StatelessWidget {
  const RouteAuthFindPw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('비밀번호 찾기 페이지')),
      body: SafeArea(child: Center(child: Text('비밀번호 찾기 페이지'),)),
    );
  }
}
