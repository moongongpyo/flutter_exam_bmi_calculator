import 'package:flutter/material.dart';


//화면에 변경이 없는 위젯, 성능이 더 좋음
class BmiResultScreen extends StatelessWidget {
  final double height;
  final double weight;

  const BmiResultScreen({
    super.key,
    required this.height,
    required this.weight,
  });

  String _calcBmi(double bmi) {
    String result = '저체중';
    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }

    return result;
  }

  Widget _buildIcon(double bmi) {
    Icon icon = const Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.deepOrangeAccent,
      size: 100,
    );
    if (bmi >= 23) {
      icon = const Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    } else if (bmi >= 18.5) {
      icon = const Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100) * (height / 100));

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _calcBmi(bmi),
              style: const TextStyle(fontSize: 36),
            ),
            _buildIcon(bmi),
          ],
        ),
      ),
    );
  }
}
