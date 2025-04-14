import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice1/const/model/model_program.dart';

class ModelReview{
  final String uid;
  final Timestamp dateCreate;
  final String uidOfModelProgram;
  final ModelProgram modelProgram;

  ModelReview({required this.uid, required this.dateCreate, required this.uidOfModelProgram, required this.modelProgram});
}