import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/value/key.dart';

class ModelReview {
  final String uid;
  final Timestamp dateCreate;
  //final String uidOfModelProgram;
  final ModelProgram modelProgram;
  final String userImg;
  final String userName;
  final String reviewText;
  final int starRating;
  final List<String> listImgUrl;

  ModelReview({
    required this.uid,
    required this.dateCreate,
    //required this.uidOfModelProgram,
    required this.modelProgram,
    required this.userImg,
    required this.userName,
    required this.reviewText,
    required this.starRating,
    required this.listImgUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyDateCreate: dateCreate,
      //keyUidOfModelProgram: uidOfModelProgram,
      keyModelProgram: modelProgram.name,
      keyUserName: userName,
      keyUserImg: userImg,
      keyReviewText: reviewText,
      keyStarRating: starRating,
      keyListImgUrl: listImgUrl,
    };
  }

  factory ModelReview.fromJson(Map<String, dynamic> json) {
    return ModelReview(
      uid: json[keyUid] as String,
      dateCreate: json[keyDateCreate] as Timestamp,
      // 이거 잘 모르겠음
      //uidOfModelProgram: json[keyUidOfModelProgram] as String,
      modelProgram: ModelProgram.fromJson(json[keyModelProgram]),
      userName: json[keyUserName] as String,
      userImg: json[keyUserImg] as String,
      reviewText: json[keyReviewText] as String,
      starRating: json[keyStarRating] as int,
      listImgUrl: (json[keyListImgUrl] as List).map((e) => e.toString()).toList(),
    );
  }
}
