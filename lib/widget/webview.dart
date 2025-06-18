import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget1 extends StatefulWidget {
  final String url;

  const WebViewWidget1({super.key,  required this.url});

  @override
  State<WebViewWidget1> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget1> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.url));
  }""

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: _controller),
    );
  }
}
