import 'package:flutter/material.dart';
import 'package:practice1/ui/route/auth/route_auth_login.dart';

class RouteSplash extends StatefulWidget {
  const RouteSplash({super.key});

  @override
  State<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends State<RouteSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).push(
        MaterialPageRoute(
        builder: (_) => RouteAuthLogin(),
        ),
      );
    });
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
