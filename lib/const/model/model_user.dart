import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/key.dart';

class ModelUser {
  final String uid; //key 값
  final Timestamp dateCreate; //  서버에 올라가는 날짜 및 시간
  final String email; // 이메일
  final String name; // 이름
  final String nickname; // 닉네임
  final String pw; // 비밀번호
  final String? userImg; // 프로필 사진
  final LoginType loginType;

  ModelUser({
    required this.uid,
    required this.dateCreate,
    required this.email,
    required this.name,
    required this.nickname,
    required this.pw,
    required this.loginType,
    this.userImg,
  });

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyDateCreate: dateCreate,
      keyEmail: email,
      keyName: name,
      keyNickName: nickname,
      keyPw: pw,
      keyUserImg: userImg,
      keyLoginType: loginType.name,
    };
  }

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      uid: json[keyUid] as String,
      dateCreate: json[keyDateCreate] as Timestamp,
      email: json[keyEmail] as String,
      name: json[keyName] as String,
      nickname: json[keyNickName] as String,
      pw: json[keyPw] as String,
      userImg: json[keyUserImg] == null ? null : json[keyUserImg] as String,
      loginType: LoginType.values.firstWhere((e) => e.name == json[keyLoginType], orElse: () => LoginType.grouch),
    );
  }
}
