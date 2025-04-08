import 'package:flutter/material.dart';

class RouteReservaion extends StatelessWidget {
  const RouteReservaion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('예약')),
      body: SafeArea(
        child: Column(
          children: [
            Text('예약 페이지'),
          ],
        ),
      ),
    );
  }
}
