import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Game extends StatefulWidget {
  Game({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'http://18.139.38.227:1000/html/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) async {
              _controller = controller;
              String fileText =
                  await rootBundle.loadString('assets/games/pacman/index.html');
              _controller.loadUrl(Uri.dataFromString(
                fileText,
                mimeType: 'text/html',
              ).toString());
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
