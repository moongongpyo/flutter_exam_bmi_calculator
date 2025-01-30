import 'package:flutter/material.dart';

import 'package:bmi_calculator/screen/bmi/bmi_screen.dart';

//stful : stateful widget 기본 틀 자동완성
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

//코드의 변경을 핫 리스타트를 해야 함
class _MainPageState extends State<MainPage> {
  int number = 10; // 전역변수,보라색


//final TextEditingController _textController = new TextEditingController();
  //final을 쓸 때는 오브젝트 타입을 생략할 수 있음
  //new 키워드 생략 가능
  //_ 언더바는 해당 클래스에서만 사용할 변수(private 키워드와 비슷)
  final _textController = TextEditingController();

  @override
  void dispose() {
    number = 11;
    _textController.dispose(); //메모리에서 해제 해줘야함
    int i = 10; //지역변수,하얀색
    print(i);
    super.dispose();
  }

  //이 안쪽은 화면을 그리는 부분이기에 바로바로 핫 리로드 됨
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              // 다음 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BmiScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.red,
                width: 100,
                height: 100
              ),
              SizedBox(height: 100),
              Container(height: 30),
              Text(
                '숫자',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              Text(
                '$number',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 70,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('ElevatedButton');
                },
                child: Text('ElevatedButton'),
              ),
              TextButton(
                onPressed: () {
                  print('TextButton');
                },
                child: Text('TextButton'),
              ),
              OutlinedButton(
                onPressed: () {
                  print('OutlinedButton');
                },
                child: Text('OutlinedButton'),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: '글자',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        print(_textController.text);
                        //화면 갱신
                        setState(() {});
                      },
                      child: Text('login'),
                    ),
                  ),
                ],
              ),
              Text(_textController.text),
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7yiyCRMJ5Cvu2syKKCGWER14jXx9vIzV5Fw&s',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/fit.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 화면 갱신
          setState(() {
            number++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
