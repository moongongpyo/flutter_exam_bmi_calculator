import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;
  int _time = 0;
  bool _isRunning = false;

  final List<String> _lapTimes = [];

  void _clickButton() {
    _isRunning = !_isRunning;
    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    setState(() {
      _timer?.cancel();
    });
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    _lapTimes.clear();
    _time = 0;
  }

  void _recordLapTime(String time) {
    if(_isRunning){
      _lapTimes.insert(0, '${_lapTimes.length + 1}등 $time');
    }
  }

  @override
  void dispose() {
// _timer가 null이 아닐 때만 cancel()을 호출하여 타이머 정리
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //몫을 구하는 계산식//밀리초이기 때문에 100으로 나눈 몫이 초임
    int sec = _time ~/ 100;
    //나머지를 구하는 계산식//초를뺀 나머지가 표시되어야 함
    String hundredth = '${_time % 100}'
        //두자리가 아니면 앞에 0을 넣음
        .padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('스톱워치'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sec',
                style: const TextStyle(fontSize: 50),
              ),
              Text(
                hundredth,
              ),
            ],
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: ListView(
              //함수형 프로그래밍, 람다식이랑 비슷
              children:
                  _lapTimes.map((time) => Center(child: Text(time))).toList(),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: const Icon(Icons.refresh),
              ),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _clickButton();
                    });
                  },
                  child: _isRunning
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow)),
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
