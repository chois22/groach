import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/route/route_main.dart';

class SearchMain extends StatefulWidget {
  final PageController pageController;
  final TextEditingController tecSearch;

  const SearchMain({
    required this.pageController,
    required this.tecSearch,
    super.key,
  });

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Gaps.v7,
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    RouteMain.vnIndexTab.value = 0;
                  },
                  child: SvgPicture.asset('assets/icon/left_arrow.svg')),
              Gaps.h10,
              Expanded(
                child: Container(
                  height: 42,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorGray50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Gaps.h16,
                      SvgPicture.asset('assets/icon/search_outline.svg', width: 20, height: 20),
                      Gaps.h6,
                      Text('검색어를 입력하세요', style: TS.s16w400(colorGray400)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Gaps.v24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('최근 검색어', style: TS.s18w700(colorBlack)),
              Text('모두 지우기', style: TS.s14w500(colorGray500)),
            ],
          ),
          Gaps.v16,
          Column(
            children: [
              Row(
                children: [
                  SearchHistory(
                    searchText: '농사',
                  ),
                  Gaps.h10,
                  SearchHistory(
                    searchText: '치유',
                  ),
                  Gaps.h10,
                  SearchHistory(
                    searchText: '농장',
                  ),
                  Gaps.h10,
                  SearchHistory(
                    searchText: '단체농사',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchHistory extends StatelessWidget {
  final String searchText;

  const SearchHistory({
    required this.searchText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 70,
        minHeight: 29,
      ),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: colorGray300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Gaps.h16,
          Text(searchText),
          Gaps.h6,
          SvgPicture.asset('assets/icon/x_icon.svg'),
          Gaps.h16,
        ],
      ),
    );
  }
}
