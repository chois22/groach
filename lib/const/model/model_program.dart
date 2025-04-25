import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/model/model_address.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/key.dart';

class ModelProgram {
  final String uid; //key 값
  final Timestamp dateCreate; //  서버에 올라가는 날짜 및 시간
  final ProgramType programType;
  final List<String> listImgUrl; // 프로그램 사진 리스트
  final String name; // 프로그램 명
  final String desc; // 프로그램 설명 description
  final double averageStarRating; // 평균 평점
  final int countTotalReview; // 전체 리뷰 수
  final int price; // 프로그램 참가비
  final int discountPercentage; // 할인율
  final String locationShortCut;
  final List<ServiceType> listServiceType; // eume 제공 서비스 리스트
  final int maxCountReserve; // 최대 예약 인원
  final Timestamp timeProgramStart; // 시작시간
  final Timestamp timeProgramEnd; // 종료시간
  final List<String> listTag; // 인스타에 # 같은 기능
  final ModelAddress modelAddress;

  ModelProgram({
    required this.uid,
    required this.dateCreate,
    required this.programType,
    required this.listImgUrl,
    required this.name,
    required this.desc,
    required this.averageStarRating,
    required this.countTotalReview,
    required this.price,
    required this.discountPercentage,
    required this.locationShortCut,
    required this.listServiceType,
    required this.maxCountReserve,
    required this.timeProgramStart,
    required this.timeProgramEnd,
    required this.listTag,
    required this.modelAddress,
  });

  // model, enum은 따로 처리해줘야함.
  Map<String, dynamic> toJson() {
    return {
      //'address_basic' : addressBasic,
      keyUid : uid,
      keyDateCreate : dateCreate,
      keyProgramType : programType.name, //enum값은 name
      keyListImgUrl : listImgUrl,
      keyName : name,
      keyDesc : desc,
      keyAverageStarRating : averageStarRating,
      keyCountTotalReview : countTotalReview,
      keyPrice : price,
      keyDiscountPercentage : discountPercentage,
      keyLocationShortCut : locationShortCut,
      keyListServiceType : listServiceType.map((e)=> e.name).toList(), //e = <ServiceType>
      keyMaxCountReserve : maxCountReserve,
      keyTimeProgramStart : timeProgramStart,
      keyTimeProgramEnd : timeProgramEnd,
      keyListTag : listTag,
      keyModelAddress : modelAddress.toJson(), //model 은 .toJson(),
    };
  }

  // 서버에서 받을떄
  factory ModelProgram.fromJson(Map<String, dynamic> json) {
    return ModelProgram(
      // addressBasic: json['address_basic'] as String,
        uid: json[keyUid] as String,
        dateCreate: json[keyDateCreate] as Timestamp,
        programType: ProgramType.values.firstWhere((e) => e.name == json[keyProgramType]),

        listImgUrl: (json[keyListImgUrl] as List).map((e) => e.toString()).toList(),
        // 서버에 저장돼 있는 값 : json[keyListImgUrl]
        // 서버에서 List로 돼 있다. map으로 리스트를 펼치고, String으로 만들어준다.
        // 그리고 다시 List로

        name: json[keyName] as String,
        desc: json[keyDesc] as String,
        averageStarRating: (json[keyAverageStarRating] as num).toDouble(),
        countTotalReview: json[keyCountTotalReview] as int,
        price: json[keyPrice] as int,
        discountPercentage: json[keyDiscountPercentage] as int,
        locationShortCut: json[keyLocationShortCut] as String,

        listServiceType: (json[keyListServiceType] as List)
          .map((e) => ServiceType.values.firstWhere((serviceType)
          => serviceType.name == e)).toList(),
        // e랑 serviceType랑 비교한다.

        maxCountReserve: json[keyMaxCountReserve] as int,
        timeProgramStart: json[keyTimeProgramStart] as Timestamp,
        timeProgramEnd: json[keyTimeProgramEnd] as Timestamp,
        listTag: (json[keyListTag] as List).map((e) => e.toString()).toList(),
        modelAddress: ModelAddress.fromJson(json[keyAddress]),
    );
  }
}


