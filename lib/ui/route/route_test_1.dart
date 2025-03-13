import 'package:flutter/material.dart';

class RouteTest1 extends StatelessWidget {
  final int number1;
  const RouteTest1({required this.number1, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text(number1.toString()),
    );
  }
}
