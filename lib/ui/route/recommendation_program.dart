import 'package:flutter/material.dart';

class RecommendationProgram extends StatelessWidget {
  const RecommendationProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('추천 프로그램 페이지')),
            ],
          ),
        ),
      ),
    );
  }
}
