//ios 스타일의 위젯 라이브러리
import 'package:flutter/cupertino.dart';

class IosStyleScreen extends StatefulWidget {
  const IosStyleScreen({super.key});

  @override
  State<IosStyleScreen> createState() => _IosStyleScreenState();
}

class _IosStyleScreenState extends State<IosStyleScreen> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('쿠퍼티노 앱'),
        ),
          child: Center(
        child: Text('쿠퍼티노 앱'),
      )),
    );
  }
}
