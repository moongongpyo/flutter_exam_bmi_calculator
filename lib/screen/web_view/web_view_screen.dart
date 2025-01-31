
import 'package:bmi_calculator/screen/stop_watch/stop_watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewScreen extends StatefulWidget {
  const webViewScreen({super.key});

  @override
  State<webViewScreen> createState() => _webViewScreenState();
}



class _webViewScreenState extends State<webViewScreen> {


  final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://flutter.dev'));


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('나만의 웹브라우저'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              _webViewController.loadRequest(Uri.parse(value));
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'https://www.google.com',
                child: Text('구글'),
              ),
              const PopupMenuItem<String>(
                value: 'https://www.naver.com',
                child: Text('네이버'),
              ),
              const PopupMenuItem<String>(
                value: 'https://www.kakao.com',
                child: Text('카카오'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              /*   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ),
              );*/
            },
          ),
        ],
      ),

      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          if (await _webViewController.canGoBack()) {
            await _webViewController.goBack();
          }else{
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
