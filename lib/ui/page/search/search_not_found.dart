import 'package:flutter/material.dart';

class SearchNotFound extends StatelessWidget {
  final PageController pageController;
  final TextEditingController tecSearch;

  const SearchNotFound({
    required this.pageController,
    required this.tecSearch,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('검색 결과 없음'),
      ],
    );
  }
}
