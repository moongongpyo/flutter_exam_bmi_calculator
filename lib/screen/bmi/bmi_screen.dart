import 'package:bmi_calculator/screen/bmi/bmi_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  //폼의 상태를 가지고 있는 것임
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  //화면이 시작될 때
  @override
  void initState() {
    super.initState();
    load();
  }

  //화면이 종료될 때
  @override
  void dispose() {
    //앱 종료시 상태 저장
    //이 부분에서 save매서드를 실행하면 저장 하기 전 아래 컨트롤러가 먼저 종료될 여지가 생긴다. 따라서 안전하지 않기에 다른 플로우에서 처리하도록 변경하는게 좋다.
    //save();

    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  //async 키워드는 코드를 비동기적으로 처리함, Future를 반환해야 함, 실행순서가 중요하지 않고 오래 걸리는 코드에서 사용한다(ex api 호출)
  Future save() async {
    //상태 저장 코드
    //await 키워드는 비동기 매서드에서 동기적으로 처리됨 //다른 Future를 반환하는 매서드가 비동기처리 매서드 안에서 사용될 때 await키워드를 사용해야 한다
    final prefs = await SharedPreferences.getInstance();
    // 값들을 공유 저장소에 임시 저장//setDouble은 Future를 반환하기 때문에 await 키워드를 사용해야 한다
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    // ?는 null을 허용한다는 뜻이다.//getDouble은 null을 반환할 여지가 있기 때문(예를 들어 저장하기 전에 값을 로드)에 double? 로 받아야 한다
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');

    //널체크를 하지 않으면 사용이 불가능하다
    if (height != null && weight != null) {
      //$는 문자열 안에서 변수를 쓸 때 사용한다.
      _heightController.text = '$height';
      _weightController.text = '$weight';
      print('키 : $height, 몸무게 : $weight');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //Form으로 감싸야 하며, 잘못된 입력값에 대한 처리를 도와줌
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '키를 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '몸무게를 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  //값이 유효하지 않다면 여기서 리턴을 하여 코드가 더이상 진행되지 않도록 막음
                  if (_formKey.currentState?.validate() == false) {
                    return;
                  }

                  save(); // 조금더 빠른 호출로 인해 안전한 비동기 처리가 가능하다.

                  //값이 유효한 경우 생성자를 통해 결과 창을 전달함
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BmiResultScreen(
                        height: double.parse(_heightController.text),
                        weight: double.parse(_weightController.text),
                      ),
                    ),
                  );
                },

                //명료하게 변수가 없으면 const를 붙이는게 성능상 좋다
                child: const Text('결과'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
