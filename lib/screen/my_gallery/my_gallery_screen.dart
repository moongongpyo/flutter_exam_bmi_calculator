import 'dart:async';
import 'dart:typed_data'; // 추가
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyGalleryScreen extends StatefulWidget {
  const MyGalleryScreen({super.key});

  @override
  State<MyGalleryScreen> createState() => _MyGalleryScreenState();
}

class _MyGalleryScreenState extends State<MyGalleryScreen> {
  final ImagePicker _picker = ImagePicker();

  int currentPage = 0;

  //XFile 은 이미지 객체다.
  List<XFile>? images;

  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    //선택된 여러 장의 이미지 불러오기
    images = await _picker.pickMultiImage();

    if (images != null) {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        currentPage++;
        if (currentPage > images!.length - 1) {
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }
    //화면 갱신
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전자 액자'),
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                /*   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ),
              );*/
              }),
        ],
      ),
      body: (images == null || images!.isEmpty)
          ? const Center(child: Text('No data'))
          //페이지 뷰
          : PageView(
              controller: pageController,
              onPageChanged: (index) {
                // 사람이 넘겼을 때 `currentPage` 업데이트
                currentPage = index;
              },
              //if문이 아닌 삼항 연산에서는 !를 통해 null이 아님을 직접 지정해 줘야 함
              children: images!.map((image) {
                //비동기 데이터(Future)를 기다리면서 UI를 동적으로 업데이트
                return FutureBuilder<Uint8List>(
                    // 이미지 바이트를 메모리에 저장
                    future: image.readAsBytes(),
                    //snapshot : future의 상태, context : 위젯 트리에서 현재 위젯의 위치 및 정보,build 함수 밖에서 사용 금지
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      if (!snapshot.hasData || data == null) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //데이터가 로딩중일때 대기중 표시
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return const Center(
                            child: Text('Failed to load image'));
                      }
                      return Image.memory(
                        data,
                        width: double.infinity,
                      );
                    });
              }).toList(),
            ),
    );
  }
}
