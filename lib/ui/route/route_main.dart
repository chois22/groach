import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';

class RouteMain extends StatelessWidget {
  const RouteMain({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
            SvgPicture.asset('assets/image/main_name.svg'),
              Icon(Icons.notifications_active_outlined),
              Icon(Icons.search_outlined),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    color: colorBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
