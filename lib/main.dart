import 'package:bmi_calculator/screen/todo_list/todo.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'main/main_page.dart';

late final Box<Todo>todos; // 파일 밖에 선언된 변수는 앱 어디에서든 쓸 수 있다//late 키워드를 통해 main 함수 호출 시점에 초기화 한다 //좋은 코드는 아니다

void main() async {
  //Future 생략 가능
  await Hive.initFlutter(); //앱 실행 로직에서 엔티티를 초기화 함
  Hive.registerAdapter(
      TodoAdapter()); //의존성 주입과 비슷//스프링처럼 서비스 객체를 주입하는 게 아니라 데이터 모델을 Hive에 등록하는 과정이기 때문에 완전히 같은 개념은 아님.
  todos = await Hive.openBox<Todo>('todolist.db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
