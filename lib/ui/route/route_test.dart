import 'package:flutter/material.dart';
import 'package:practice1/ui/route/route_test_1.dart';
import 'package:practice1/ui/route/route_test_2.dart';

class RouteTest extends StatelessWidget {
  const RouteTest({super.key});

  @override
  Widget build(BuildContext context) {
    final int number1 = 1;
    final int number2 = 2;
    final int number3 = 3;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (_) => RouteTest1(number1: number2),
                    ),
                  );
                },
                child: Text('버튼 1'),
              ),
        
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => RouteTest2(),
                    ),
                  );
                },
                child: Text('버튼 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
