import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/value/key.dart';

class ModelAddress {
  final String addressBasic; // 경기도 화성시 우정읍 465-7
  final String addressDetail; // 직원아파트 405호
  final String addressPostCode; // 우편번호
  final GeoPoint addressGeoPoint; // 위도 경도(firebase 형식)
  final String addressRegion; // 지역(서울 경기 부산 충남 충북 등등)

  ModelAddress({
    required this.addressBasic,
    required this.addressDetail,
    required this.addressPostCode,
    required this.addressGeoPoint,
    required this.addressRegion,
  });

  // 서버에 보낼 때
  Map<String, dynamic> toJson() {
    return {
      //'address_basic' : addressBasic,
      keyAddressBasic: addressBasic,
      keyAddressDetail: addressDetail,
      keyAddressPostCode: addressPostCode,
      keyAddressGeoPoint: addressGeoPoint,
      keyAddressRegion: addressRegion,
    };
  }

  // 서버에서 받을떄
  factory ModelAddress.fromJson(Map<String, dynamic> json) {
    return ModelAddress(
      // addressBasic: json['address_basic'] as String,
      addressBasic: json[keyAddressBasic] as String,
      addressDetail: json[keyAddressDetail] as String,
      addressPostCode: json[keyAddressPostCode] as String,
      addressGeoPoint: json[keyAddressGeoPoint] as GeoPoint,
      addressRegion: json[keyAddressRegion] as String,
    );
  }
}
