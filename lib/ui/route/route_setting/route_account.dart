import 'package:flutter/material.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/key.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteAccount extends StatelessWidget {
  const RouteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('계정 관리', style: TS.s18w600(colorBlack))),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences spf = await SharedPreferences.getInstance();

                  await spf.remove(keyUid);

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => RouteAuthLogin(),
                    ),
                    (route) => false,
                  );
                },
                child: Text('로그아웃'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
