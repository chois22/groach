import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/model/model_address.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:uuid/uuid.dart';

final List<String> listMainBanner = [
  'assets/image/banner1.png',
  'assets/image/banner2.png',
  'assets/image/banner3.png',
  'assets/image/banner4.png',
];

final List<String> listTitleMainBottomNavi = [
  '홈',
  '검색',
  '마이페이지',
];

final List<String> listImgSelectedMainBottomNavi = [
  'assets/icon/home_green.svg',
  'assets/icon/search_green.svg',
  'assets/icon/my_green.svg',
];

final List<String> listImgOutlinedMainBottomNavi = [
  'assets/icon/home_outline.svg',
  'assets/icon/search_outline.svg',
  'assets/icon/my_outline.svg',
];

/// 서버 연결 전에 테스트로 사용하는 프로그램 모델 리스트
final List<ModelProgram> listSampleModelProgram = [

  /// 인기 프로그램
  ModelProgram(
    uid: Uuid().v1(),
    dateCreate: Timestamp.now(),
    programType: ProgramType.popular,
    listImgUrl: [
      'assets/image/program_card_image1.png',
      'assets/image/program_card_image2.png',
      'assets/image/program_card_image3.png',
      'assets/image/program_card_image4.png',
    ],
    name: '경복궁 한복 체험',
    desc: "아름다운 한복을 입고 경복궁에서 전통 문화를 체험할 수 있어요.",
    averageStarRating: 4.5,
    countTotalReview: 1543,
    price: 10000,
    discountPercentage: 20,
    locationShortCut: "경복궁역 4번 출구에서 100m",
    listServiceType: [ServiceType.wifi, ServiceType.pet],
    maxCountReserve: 20,
    timeProgramStart: Timestamp.now(),
    timeProgramEnd: Timestamp.now(),
    listTag: ['한복', '경복궁'],
    modelAddress: ModelAddress(
      addressBasic: "서울 종로구 시작로 161",
      addressDetail: "경복궁 입구",
      addressPostCode: "03045",
      addressGeoPoint: GeoPoint(37.5796, 126.977),
      addressRegion: "서울",
    ),
  ),

  /// 농사 프로그램
  ModelProgram(
    uid: Uuid().v1(),
    dateCreate: Timestamp.now(),
    programType: ProgramType.farm,
    listImgUrl: [
      'assets/image/program_card_image2.png',
      'assets/image/program_card_image1.png',
      'assets/image/program_card_image3.png',
      'assets/image/program_card_image4.png',
    ],
    name: '농사 체험',
    desc: "농사를 직접 체험할 수 있어요. 너무 너무 즐거울 겁니다.",
    averageStarRating: 4.4,
    countTotalReview: 1443,
    price: 9000,
    discountPercentage: 25,
    locationShortCut: "천안역 1번 출구에서 200m",
    listServiceType: [ServiceType.pet, ServiceType.parking],
    maxCountReserve: 20,
    timeProgramStart: Timestamp.now(),
    timeProgramEnd: Timestamp.now(),
    listTag: ['농사', '체험'],
    modelAddress: ModelAddress(
      addressBasic: "전안 천안동 111",
      addressDetail: "천안역 입구",
      addressPostCode: "12345",
      addressGeoPoint: GeoPoint(36.5796, 126.977),
      addressRegion: "천안",
    ),
  ),

  /// 호캉스 프로그램
  ModelProgram(
    uid: Uuid().v1(),
    dateCreate: Timestamp.now(),
    programType: ProgramType.hokangs,
    listImgUrl: [
      'assets/image/program_card_image3.png',
      'assets/image/program_card_image2.png',
      'assets/image/program_card_image1.png',
      'assets/image/program_card_image4.png',
    ],
    name: '호캉스 체험',
    desc: "호캉스를 직접 체험할 수 있어요. 너무 즐거울 겁니다.",
    averageStarRating: 4.3,
    countTotalReview: 1343,
    price: 8000,
    discountPercentage: 30,
    locationShortCut: "서울역 1번 출구에서 300m",
    listServiceType: [ServiceType.wifi, ServiceType.pet, ServiceType.parking],
    maxCountReserve: 20,
    timeProgramStart: Timestamp.now(),
    timeProgramEnd: Timestamp.now(),
    listTag: ['호캉스', '체험'],
    modelAddress: ModelAddress(
      addressBasic: "서울 중심가 222",
      addressDetail: "서울역 1번 출구",
      addressPostCode: "23456",
      addressGeoPoint: GeoPoint(35.5796, 125.977),
      addressRegion: "서울",
    ),
  ),

  /// 인기 프로그램
  ModelProgram(
    uid: Uuid().v1(),
    dateCreate: Timestamp.now(),
    programType: ProgramType.hot,
    listImgUrl: [
      'assets/image/program_card_image4.png',
      'assets/image/program_card_image2.png',
      'assets/image/program_card_image1.png',
      'assets/image/program_card_image3.png',
    ],
    name: '인기 많은 체험',
    desc: "인기 많은 프로그램을 직접 체험할 수 있어요. 너무 즐거울 겁니다.",
    averageStarRating: 4.2,
    countTotalReview: 1243,
    price: 7000,
    discountPercentage: 35,
    locationShortCut: "수원역 1번 출구에서 400m",
    listServiceType: [ServiceType.wifi, ServiceType.pet, ServiceType.parking],
    maxCountReserve: 20,
    timeProgramStart: Timestamp.now(),
    timeProgramEnd: Timestamp.now(),
    listTag: ['인기', '체험'],
    modelAddress: ModelAddress(
      addressBasic: "수원 수원 333",
      addressDetail: "수원역 입구",
      addressPostCode: "34567",
      addressGeoPoint: GeoPoint(34.5796, 124.977),
      addressRegion: "수원",
    ),
  ),
];
