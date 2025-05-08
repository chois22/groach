import 'package:flutter/material.dart';
import 'package:practice1/const/model/model_user.dart';

class Global {
 static BuildContext? contextSplash;

 static ValueNotifier<ModelUser?> userNotifier = ValueNotifier(null);
}