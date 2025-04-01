import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/textfield_search.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({super.key});

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  final TextEditingController tecSearch = TextEditingController();
  ValueNotifier<String> vnSearchText = ValueNotifier<String>('');
  ValueNotifier<List<String>> vnSearchHistory = ValueNotifier<List<String>>([]);
  ValueNotifier<bool> vnShowNoResults = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    tecSearch.addListener(_onSearchTextChanged);
    _loadSearchHistory();
  }

  @override
  void dispose() {
    tecSearch.removeListener(_onSearchTextChanged);
    super.dispose();
  }

  void _onSearchTextChanged() {
    vnSearchText.value = tecSearch.text;
    vnShowNoResults.value = false;
  }

  // 저장된 검색 기록을 SharedPreferences에서 불러오는 함수
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    vnSearchHistory.value = prefs.getStringList('search_history') ?? [];
  }

  // 새로운 검색어를 저장하는 함수
  Future<void> _saveSearchHistory(String search) async {
    if (search.isEmpty || vnSearchHistory.value.contains(search)) return; // 빈 값 또는 중복 값 방지
    final prefs = await SharedPreferences.getInstance();
    final updatedHistory = [search, ...vnSearchHistory.value]; // 최신 검색어가 앞에 오도록 삽입
    vnSearchHistory.value = updatedHistory;
    await prefs.setStringList('search_history', updatedHistory);
  }

  // 모든 검색 기록 삭제 함수
  Future<void> _clearAllHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('search_history');
    vnSearchHistory.value = [];
  }

  // 특정 검색 기록 삭제 함수
  Future<void> _removeHistoryItem(String search) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedHistory = List<String>.from(vnSearchHistory.value)..remove(search);
    vnSearchHistory.value = updatedHistory;
    await prefs.setStringList('search_history', updatedHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: 42,
            child: Stack(
              children: [
                TextFieldSearch(
                  controller: tecSearch,
                  hintText: '검색어를 입력해주세요',
                  suffixIcon: null,
                  colorBorder: colorGray50,
                  //todo : 이거 색깔 바꾸는 법
                  fillColor: tecSearch.text.isEmpty ? colorGray50 : colorWhite,
                  onChanged: (text) {
                    vnSearchText.value = text;
                    vnShowNoResults.value = false;
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: vnSearchText,
                  builder: (context, searchText, child) {
                    if (searchText.isEmpty) {
                      return Container();
                    } else {
                      return Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 42,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  tecSearch.clear(); // 입력 필드 초기화
                                  vnSearchText.value = ''; // 검색 텍스트 초기화
                                //  vnShowNoResults.value = false;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(66.67),
                                    color: colorGray200, // 배경색
                                  ),
                                  height: 16,
                                  width: 16,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icon/x_icon.svg',
                                      width: 10.67,
                                      height: 10.67,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _saveSearchHistory(tecSearch.text); // 검색어 저장
                                  tecSearch.clear(); // 입력 필드 초기화
                                  vnSearchText.value = ''; // 검색 텍스트 초기화

                                  if (searchText == '수원') {
                                    vnShowNoResults.value = false;
                                  } else {
                                    vnShowNoResults.value = true;
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 16),
                                  child: SvgPicture.asset(
                                    'assets/icon/search_outline.svg',
                                    colorFilter: ColorFilter.mode(colorGreen600, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Gaps.v16,


        ValueListenableBuilder<bool>(
          valueListenable: vnShowNoResults,
          builder: (context, show, child) {
            if (!show) return Container();

            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(vnSearchText.value == '수원')
                      Container(
                        child: Text('fdsafasd'),
                        color: Colors.red,
                      ),

                    if(vnSearchText.value != '수원')
                      Column(
                        children: [
                          SvgPicture.asset('assets/icon/notfound_icon.svg'),
                          Gaps.v16,
                          Text('검색 결과가 존재하지 않아요.', style: TS.s16w500(colorGray700)),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),

        ValueListenableBuilder<String>(
          valueListenable: vnSearchText,
          builder: (context, searchText, child) {
            return ValueListenableBuilder<List<String>>(
              valueListenable: vnSearchHistory,
              builder: (context, searchHistory, child) {
                if (searchText.isNotEmpty || vnShowNoResults.value) {
                  return Container();
                }
                if (searchHistory.isEmpty) return Container();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('최근 검색어', style: TS.s18w700(colorBlack)),
                          GestureDetector(
                            onTap: _clearAllHistory,
                            child: Text('모두 지우기', style: TS.s14w500(colorGray500)),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: searchHistory.map((text) {
                          return SearchHistory(recentText: text, onDelete: _removeHistoryItem);
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class SearchHistory extends StatelessWidget {
  final String recentText;
  final Function(String) onDelete;

  const SearchHistory({
    required this.recentText,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: colorGray300, width: 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(recentText, style: TS.s14w500(colorGray800)), // 검색 기록 텍스트
          Gaps.h8,
          GestureDetector(
            onTap: () => onDelete(recentText), // 개별 검색 기록 삭제
            child: SvgPicture.asset('assets/icon/x_icon.svg'),
          ),
        ],
      ),
    );
  }
}

/// shared_preferences 2.5.3
// Expanded(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       SvgPicture.asset('assets/icon/notfound_icon.svg'),
//       Gaps.v16,
//       Text('검색 결과가 존재하지 않아요.', style: TS.s16w500(colorGray700)),
//     ],
//   ),
// ),
// Expanded(
//   child: SingleChildScrollView(
//   ),
// ),
