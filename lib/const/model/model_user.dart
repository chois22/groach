import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/value/key.dart';

class ModelUser {
  final String uid; //key 값
  final Timestamp dateCreate; //  서버에 올라가는 날짜 및 시간
  final String email; // 이메일
  final String name; // 이름
  final String nickname; // 닉네임
  final String pw; // 비밀번호
  final String pwCheck; // 비밀번호 확인

  ModelUser({
    required this.uid,
    required this.dateCreate,
    required this.email,
    required this.name,
    required this.nickname,
    required this.pw,
    required this.pwCheck,
  });

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyDateCreate: dateCreate,
      keyEmail: email,
      keyName : name,
      keyNickName: nickname,
      keyPw: pw,
      keyPwCheck: pwCheck,
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
      pwCheck: json[keyPwCheck] as String,
    );
  }
}
