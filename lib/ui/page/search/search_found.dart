import 'package:flutter/material.dart';

class SearchFound extends StatelessWidget {
  final PageController pageController;
  final TextEditingController tecSearch;

  const SearchFound({
    required this.pageController,
    required this.tecSearch,
    super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('검색결과 있음'),
      ],
    );
  }
}
