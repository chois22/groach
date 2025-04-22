import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/model/model_program.dart';
import 'package:practice1/const/model/model_user.dart';
import 'package:practice1/const/value/enum.dart';
import 'package:practice1/const/value/key.dart';

class ModelReview {
  final String uid;
  final Timestamp dateCreate;

  //final String uidOfModelProgram;
  final ModelProgram modelProgram;
  final ModelUser modelUser;
  final String reviewText;
  final int starRating;
  final List<String> listImgUrl;

  ModelReview({
    required this.uid,
    required this.dateCreate,
    //required this.uidOfModelProgram,
    required this.modelProgram,
    required this.modelUser,
    required this.reviewText,
    required this.starRating,
    required this.listImgUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      keyUid: uid,
      keyDateCreate: dateCreate,
      //keyUidOfModelProgram: uidOfModelProgram,
      keyModelProgram: modelProgram.toJson(),
      keyModelUser: modelUser.toJson(),
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
      modelUser: ModelUser.fromJson(json[keyModelUser]),
      reviewText: json[keyReviewText] as String,
      starRating: json[keyStarRating] as int,
      listImgUrl: (json[keyListImgUrl] as List).map((e) => e.toString()).toList(),
    );
  }
}
