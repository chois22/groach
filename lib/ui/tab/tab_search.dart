import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/component/textfield_search.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences 2.5.3 (검색창 패키지)
class TabSearch extends StatefulWidget {
  const TabSearch({super.key});

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  final TextEditingController tecSearch = TextEditingController();
  final ValueNotifier<List<String>> vnListSearchHistory = ValueNotifier<List<String>>([]);
  final ValueNotifier<bool?> vnHasData = ValueNotifier(null);
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  @override
  void dispose() {
    tecSearch.dispose();
    vnListSearchHistory.dispose();
    vnHasData.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // 저장된 검색 기록을 SharedPreferences에서 불러오는 함수
  Future<void> _loadSearchHistory() async {
    final spf = await SharedPreferences.getInstance();
    vnListSearchHistory.value = spf.getStringList('list_search_keyword') ?? [];
  }

  // 새로운 검색어를 저장하는 함수
  Future<void> _saveSearchHistory(String search) async {
    // 텍스트 입력창이 비어있으면 그대로 리턴
    if (tecSearch.text.isEmpty) return;

    final spf = await SharedPreferences.getInstance();
    List<String> listKeyword = List.from(vnListSearchHistory.value);
    // 중복되는 검색어가 있으면 그대로 리턴
    if (listKeyword.contains(tecSearch.text)) return;
    // 최근 검색어가 맨 앞으로 배치되도록.
    listKeyword.insert(0, tecSearch.text);
    // listKeyword.add(tecSearch.text);
    await spf.setStringList('list_search_keyword', listKeyword);

    vnListSearchHistory.value = List.from(listKeyword);
  }

  // 모든 검색 기록 삭제 함수
  Future<void> _clearAllHistory() async {
    final spf = await SharedPreferences.getInstance();
    await spf.remove('list_search_keyword');
    vnListSearchHistory.value = [];
  }

  // 특정 검색 기록 삭제 함수
  Future<void> _removeHistoryItem(String search) async {
    final spf = await SharedPreferences.getInstance();
    final updatedHistory = List<String>.from(vnListSearchHistory.value)..remove(search);
    vnListSearchHistory.value = updatedHistory;
    await spf.setStringList('list_search_keyword', updatedHistory);
  }

  // todo : 최근 검색어 누르면 검색하는 기능 추가
  void _search(String searchText) async {
    await _saveSearchHistory(searchText);
    tecSearch.text = searchText; //
    vnHasData.value = true; //
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
                ValueListenableBuilder(
                  valueListenable: tecSearch,
                  builder: (context, _, child) => TextFieldSearch(
                    controller: tecSearch,
                    focusNode: focusNode,
                    hintText: '검색어를 입력해주세요',
                    suffixIcon: null,
                    prefixIcon: focusNode.hasFocus
                        ? null
                        : Padding(
                            padding: const EdgeInsets.only(left: 16, right: 6),
                            child: SvgPicture.asset('assets/icon/search_outline.svg'),
                          ),
                    colorBorder: colorGray50,
                    fillColor: (focusNode.hasFocus || tecSearch.text.isNotEmpty) ? colorWhite : colorGray50,
                    onChanged: (text) {
                      vnHasData.value = null;
                    },
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: tecSearch,
                  builder: (context, tec, child) {
                    if (tec.text.isEmpty) {
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
                              /// (x) 누르면 검색어 삭제
                              GestureDetector(
                                onTap: () {
                                  // 입력 필드 초기화
                                  tecSearch.clear();

                                  // 검색 결과가 존재하지 않습니다. 출력 초기화
                                  vnHasData.value = null;
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
                                /// 검색어 입력 후 돋보기 아이콘 누르면 vnHasData값을 false로 저장.
                                /// 검색어 저장
                                onTap: () async {
                                  await _saveSearchHistory(tecSearch.text);

                                  vnHasData.value = false;
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
        ValueListenableBuilder(
          valueListenable: tecSearch,
          builder: (context, tec, child) => ValueListenableBuilder<bool?>(
            valueListenable: vnHasData,
            builder: (context, hasData, child) {
              // if (hasData == true)
              // Todo : hasDate가 true일때 검색 기능 실행을 넣으려고 바꿈
              if (tecSearch.text.isEmpty) {
                // hasData가 true면 최근 검색어 보여주기.
                return _ScreenSearchKeyword(
                    tecSearch: tecSearch,
                    vnListSearchHistory: vnListSearchHistory,
                    vnHasData: vnHasData,
                    onDeleteAllTap: _clearAllHistory,
                    onKeyWordDeleteTap: _removeHistoryItem,
                    onKeyWordTap: _search,
                    /// 전달  vnListSearchHistory:vnListSearchHistory,
                    );

                // Todo : hasDate 가 true 일때 '검색결과'라고 표시
              }
              if (hasData == true) {
                return Center(child: Text('${tecSearch.text} 검색결과'));
              } else if (hasData == false) {
                return _ScreenNoResult();
              }

              // 최근 검색어 (돋보기가 없어서 검색을 할 수 없음)
              else if (tec.text.isEmpty) {
                return Container(
                  child: Center(
                    child: Text('검색어가 없어서 최근 검색어를 보여줌'),
                  ),
                );
              }

              /// 검색어 입력중일 때
              else {
                return Container(
                  child: Center(
                    child: Text('검색어를 입력중'),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class SearchHistory extends StatelessWidget {
  final String recentText;
  final Function(String) onKeyWordDeleteTap;
  final Function(String) onKeyWordTap;

  const SearchHistory({
    required this.recentText,
    required this.onKeyWordDeleteTap,
    required this.onKeyWordTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onKeyWordTap(recentText),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: colorGray300, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 4, top: 6, bottom: 6),
                    child: Text(recentText, style: TS.s14w500(colorGray800)),
                  ), // 검색 기록 텍스트
                ],
              ),
            ),
            GestureDetector(
              onTap: () => onKeyWordDeleteTap(recentText), // 개별 검색 기록 삭제
              child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, top: 6, bottom: 6, right: 16),
                    child: SvgPicture.asset('assets/icon/x_icon.svg'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreenSearchKeyword extends StatelessWidget {
  final TextEditingController tecSearch;
  final ValueNotifier<List<String>> vnListSearchHistory;
  final ValueNotifier<bool?> vnHasData;
  final void Function() onDeleteAllTap;

  final Function(String) onKeyWordDeleteTap;
  final Function(String) onKeyWordTap;

  const _ScreenSearchKeyword({
    required this.tecSearch,
    required this.vnListSearchHistory,
    required this.vnHasData,
    required this.onDeleteAllTap,

    required this.onKeyWordDeleteTap,
    required this.onKeyWordTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      ///tec로
      valueListenable: tecSearch,
      builder: (context, tec, child) {
        return ValueListenableBuilder<List<String>>(
          valueListenable: vnListSearchHistory,
          builder: (context, searchHistory, child) {
            if (tec.text.isNotEmpty || vnHasData.value == true) {
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
                        onTap: onDeleteAllTap,
                        child: Text('모두 지우기', style: TS.s14w500(colorGray500)),
                      ),
                    ],
                  ),
                ),
                Gaps.v16,

                /// 글씨부분을 누르면 검색어에 입력되어 결과가 표시되기
                /// x를 누르면 그 검색어가 사라지기
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: searchHistory.map((text) {
                      return SearchHistory(
                        recentText: text,
                        onKeyWordDeleteTap: onKeyWordDeleteTap,
                        onKeyWordTap: onKeyWordTap,
                        // onKeyWordDeleteTap: _removeHistoryItem,
                        // onKeyWordTap: (searchText) => _search(searchText),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ScreenHasData extends StatelessWidget {
  const _ScreenHasData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _ScreenNoResult extends StatelessWidget {
  const _ScreenNoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icon/notfound_icon.svg'),
              Gaps.v16,
              Text('검색 결과가 존재하지 않아요.', style: TS.s16w500(colorGray700)),
            ],
          ),
        ),
      ),
    );
  }
}
