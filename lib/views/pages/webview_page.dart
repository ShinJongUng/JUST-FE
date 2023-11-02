import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String title;
  final String url;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
