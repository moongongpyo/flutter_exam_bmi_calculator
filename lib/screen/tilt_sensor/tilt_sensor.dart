import 'package:bmi_calculator/screen/xylophone/xylophone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:bmi_calculator/util/orientation_util.dart';

class TiltSensor extends StatefulWidget {
  const TiltSensor({super.key});

  @override
  State<TiltSensor> createState() => _TiltSensorState();
}

class _TiltSensorState extends State<TiltSensor> {


  @override
  void initState() {
    super.initState();
    OrientationUtil.setLandscape(); // 가로 모드 적용
  }

  @override
  void dispose() {
    OrientationUtil.setPortrait(); // 세로 모드 적용
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    //위젯의 크기의 절반을 빼줘야 함
    final centerX = MediaQuery.of(context).size.width / 2 - 50;
    final centerY = MediaQuery.of(context).size.height / 2 - 50;

    return Scaffold(
      appBar: AppBar(
        title: const Text('수평 측정기'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Xylophone()),
              );
            },
          ),
        ],
      ),
      //Stack은 여러 개의 위젯이 z 축으로 겹칠 수 있게 해줌
      body: Stack(
        children: [
          //정확한 수치로 위젯의 위치를 잡아줌
          StreamBuilder<AccelerometerEvent>(
              stream: accelerometerEvents,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final event = snapshot.data!;

                return Positioned(
                  left: centerX + event.y * 20,
                  top: centerY + event.x * 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      //밖에 컬러가 있으면 지우고 안에서 사용해야 함
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    width: 100,
                    height: 100,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
